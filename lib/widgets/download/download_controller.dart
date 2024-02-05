
import 'package:books/config/com_area.dart';
import 'package:books/features/import_export/data/models/file_backup.module.dart';
import 'package:books/features/import_export/data/services/import_export.service.dart';
import 'package:books/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/features/libro/data/services/db_libro.service.dart';
import 'package:books/injection_container.dart';
import 'package:books/models/libro_to_save.module.dart';
import 'package:books/resources/item_exception.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:books/widgets/download/download_button.dart';
import 'package:flutter/widgets.dart';

abstract class DownloadController implements ChangeNotifier {
  DownloadStatus get downloadStatus;
  double get progress;
  int get nrRecordCaricati;
  List<LibroViewModel> get lstLibriGiaPresenti;

  void startDownload();
  void stopDownload();
  void openDownload(bool ok);
}

class FileLibreriaDownloadController extends DownloadController with ChangeNotifier {
  
  FileLibreriaDownloadController({
    DownloadStatus downloadStatus = DownloadStatus.notDownloaded,
    required Function onOpenDownload,
    required FileBackupModel fileBackupModel
  })  : _downloadStatus = downloadStatus,
        _progress = 0.0,
        _nrRecordCaricati = 0,
        _lstLibriGiaPresenti = [],
        _onOpenDownload = onOpenDownload,
        _fileBackupModel = fileBackupModel;

  DownloadStatus _downloadStatus;

  @override
  DownloadStatus get downloadStatus => _downloadStatus;

  double _progress;
  @override
  double get progress => _progress;

  int _nrRecordCaricati;
  @override
  int get nrRecordCaricati => _nrRecordCaricati;

  final List<LibroViewModel> _lstLibriGiaPresenti;
  @override
  List<LibroViewModel> get lstLibriGiaPresenti => _lstLibriGiaPresenti;

  final Function _onOpenDownload;
  final FileBackupModel _fileBackupModel;

  // int get nrRecordCaricati => 

  bool _isDownloading = false;

  @override
  void startDownload() {
    if (downloadStatus == DownloadStatus.notDownloaded) {
      _caricaLibriInLibreria();
    }
  }

  @override
  void stopDownload() {
    if (_isDownloading) {
      _isDownloading = false;
      _downloadStatus = DownloadStatus.notDownloaded;
      _progress = 0.0;
      notifyListeners();
    }
  }

  @override
  void openDownload(bool ok) {
    if (downloadStatus == DownloadStatus.downloaded) {
      _onOpenDownload(ok);
    }
  }

  Future<void> _caricaLibriInLibreria() async {
    _isDownloading = true;
    _downloadStatus = DownloadStatus.fetchingDownload;
    notifyListeners();

    // Wait a second to simulate fetch time.
    await Future<void>.delayed(const Duration(seconds: 1));

    // If the user chose to cancel the download, stop the simulation.
    if (!_isDownloading) {
      return;
    }

    // Shift to the downloading phase.
    _downloadStatus = DownloadStatus.downloading;
    notifyListeners();

    // INIT
    int nrRecordTot = _fileBackupModel.nrRecord;

    ImportExportService importExportService = sl<ImportExportService>();
    List<LibroViewModel> lstLibroViewModel = await importExportService.restoreFileBackup(null, _fileBackupModel.fileName);
    
    if (lstLibroViewModel.isNotEmpty) {
      DbLibroService dbLibroService = sl<DbLibroService>();
      DbLibreriaIsarService dbLibreriaIsarService = sl<DbLibreriaIsarService>();

      List downloadProgressStops =  List.generate(nrRecordTot, (i) => (i * 100/(nrRecordTot - 1)).roundToDouble() / 100);
      String siglaLibreria = ComArea.libreriaInUso!.sigla.toString();

      int i = 0;
      for (var libroModelNew in lstLibroViewModel) {
        libroModelNew.siglaLibreria = siglaLibreria;
        libroModelNew.dataInserimento = Utils.getDataNow();
        libroModelNew.dataUltimaModifica = Utils.getDataNow();

        try {
          await dbLibroService.saveLibroToDb(LibroToSaveModel(libroModelNew), true);
          await dbLibreriaIsarService.addLibriInLibreriaInUso(ComArea.libreriaInUso!.sigla, 1);
          LibroUtils.addNrLibriCaricatiInCache(ComArea.libreriaInUso!.sigla);

          await Future<void>.delayed(const Duration(milliseconds: 50));
          _nrRecordCaricati++;
        } on ItemPresentException {
          _lstLibriGiaPresenti.add(libroModelNew);
        } catch (e) {
          rethrow;
        }

        _progress = downloadProgressStops[i++];
        notifyListeners();
      }
    }

    // Wait a second to simulate a final delay.
    await Future<void>.delayed(const Duration(seconds: 1));

    // If the user chose to cancel the download, stop the simulation.
    if (!_isDownloading) {
      return;
    }

    // Shift to the downloaded state, completing the simulation.
    _downloadStatus = DownloadStatus.downloaded;
    _isDownloading = false;
    notifyListeners();
  }
}