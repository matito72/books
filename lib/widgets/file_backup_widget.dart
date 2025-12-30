import 'package:book/features/import_export/data/models/file_backup.module.dart';
import 'package:book/widgets/download/download_button.dart';
import 'package:book/widgets/download/download_controller.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FileBackupWidget extends StatelessWidget {
  final FileBackupModel _item;
  final int _index;
  final num _nrTot;
  final void Function(BuildContext context, FileBackupModel fileBackupModel) shareFileBackup;
  final void Function(BuildContext context, FileBackupModel fileBackupModel) deleteFileBackup;

  const FileBackupWidget({super.key, required FileBackupModel item, required int index, required num nrTot, 
    required this.shareFileBackup, required this.deleteFileBackup}) : _nrTot = nrTot, _index = index, _item = item;

  @override
  Widget build(BuildContext context) {
    void openDownload(bool ok) {
      if (ok) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alcuni libri non sono stati caricati perché già presenti')),
        );
      }
    }

    final downloadController = FileLibreriaDownloadController(
      fileBackupModel: _item,
      onOpenDownload: openDownload
    );

    LinearPercentIndicator createLinearPercentIndicator(FileLibreriaDownloadController ctrl) {
      return LinearPercentIndicator(
        key: super.key,
        width: (MediaQuery.of(context).size.width * 85 / 100),
        lineHeight: 5.0,
        trailing: Text("${ctrl.nrRecordCaricati}/${_item.nrRecord}"),
        progressBorderColor: Colors.redAccent,
        progressColor: Colors.greenAccent,
        percent: ctrl.progress,
        animation: true,
        animateFromLastPercent: true,
        animateToInitialPercent: true,
      );
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: Text(
                    '${_item.fileName.substring(0, _item.fileName.indexOf('_'))} - ${_item.nrRecord} libri',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white) ,
                    textAlign: TextAlign.left,
                  ),
                ),
                Text(
                  '${_index+1}/$_nrTot',
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.right,
                )
              ]
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${_item.dtUltimaModifica.toString()}\t\t ${_item.fileSize} KB',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.white70
                    ),
                  ),
                ),
              ],
            ),
            trailing: Wrap(
              alignment: WrapAlignment.start, // Allineamento orizzontale
              crossAxisAlignment: WrapCrossAlignment.center, // <--- Fondamentale per l'allineamento verticale
              spacing: 8.0, // Aggiunge spazio tra i widget se necessario
              children: [
                SizedBox(
                  // Usare LayoutBuilder o definire altezze fisse è spesso più sicuro di MediaQuery
                  // per piccoli elementi UI, ma manteniamo la tua logica:
                  width: (MediaQuery.of(context).size.width * 10 / 100),
                  height: (MediaQuery.of(context).size.height * 6 / 100),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: downloadController,
                      builder: (context, child) {
                        return DownloadButton(
                          status: downloadController.downloadStatus,
                          downloadProgress: downloadController.progress,
                          onDownload: downloadController.startDownload,
                          onCancel: downloadController.stopDownload,
                          onOpen: downloadController.openDownload,
                          lstLibriGiaPresenti: downloadController.lstLibriGiaPresenti,
                          fileBackupModel: _item,
                        );
                      },
                    ),
                  ),
                ),
                IconButton(
                  // Rimuovere il padding extra se vuoi che l'icona sia perfettamente centrata
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(Icons.share, color: Colors.lightGreen[200]),
                  onPressed: () => shareFileBackup(context, _item),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(Icons.delete, color: Colors.orange.shade800),
                  onPressed: () => deleteFileBackup(context, _item),
                ),
              ],
            ),
          ),
          Visibility(
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            visible: true, 
            child: AnimatedBuilder(
              animation: downloadController,
              builder: (context, child) {
                return createLinearPercentIndicator(downloadController);
              },
            ),
          ),
        ],
      ),
    );
  }
}