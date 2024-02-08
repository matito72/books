import 'package:books/config/com_area.dart';
import 'package:books/features/import_export/data/services/import_export.service.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/features/libro/bloc/libro_state.bloc.dart';
import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/features/libro/data/services/db_libro_isar.service.dart';

import 'package:books/injection_container.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:books/utilities/libro_utils.dart';
import 'package:books/utilities/list_items_utils.dart';
import 'package:books/utilities/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibroBloc extends Bloc<LibroEvent, LibroState> {
  final DbLibroIsarService _dbLibroService;

  LibroState get libroBlocState => super.state;

  LibroBloc(this._dbLibroService) : super(const LibroWaitingState()) {

    // ** INIT
    on<InitLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        // if (!_dbLibroService.isServiceInitialized()) {
        //   await _dbLibroService.init();
        // }
        
        emit(const LibroInitializedState("Init DB"));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** LOAD
    on<LoadLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        ComArea.nrLibriInLibreriaInUso = 0;
        ComArea.nrLibriVisibiliInLista = 0;
        List<LibroIsarModel> lstLibroView = [];
        List<LibreriaIsarModel> lstLibreriaSel = event.lstLibreriaIsarSel;
        for (LibreriaIsarModel libreriaModel in lstLibreriaSel) {
          List<LibroIsarModel> lstTmp = await _dbLibroService.readLstLibroFromDb(libreriaModel);
          lstLibroView.addAll(lstTmp);
          ComArea.nrLibriInLibreriaInUso += libreriaModel.nrLibriCaricati;  // Tot. Nr. libri contenuti nella libreria
          ComArea.nrLibriVisibiliInLista += lstTmp.length;                  //      Nr. libri che corrispondono al filtro <= Tot.Nr.Libri Libreria
        }

        String msg = lstLibroView.isEmpty ? 'Nessun Libro presente' : 'Nr. ${lstLibroView.length}, libri caricati correttamente';

        // ORDER BY
        lstLibroView.sort((a, b) => _dbLibroService.libroViewModelSort(a, b, ComArea.lstBookOrderBy));

        // ASC - DESC
        if (!ComArea.orderByAsc) {
          lstLibroView = lstLibroView.reversed.toList();
        }

        emit(ListaLibroLoadedState(ListItemsUtils.convertListToSelectedItems(lstLibroView), msg));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // CHECK
    on<CheckAllLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        final List<SelectedItem<LibroIsarModel>> lstSelectedItem = event.lstSelectedItem;
        ListItemsUtils.selectedAllItems(lstSelectedItem);
        
        String msg = lstSelectedItem.isEmpty ? 'Nessun Libro selezionato' : 'Nr. ${lstSelectedItem.length}, libri selezionati';
        emit(ListaLibroLoadedState(lstSelectedItem, msg));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    //DE-CHECK
    on<DeCheckAllLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        final List<SelectedItem<LibroIsarModel>> lstSelectedItem = event.lstSelectedItem;
        ListItemsUtils.deselectedAllItems(lstSelectedItem);
        
        String msg = lstSelectedItem.isEmpty ? 'Nessun Libro deselezionato' : 'Nr. ${lstSelectedItem.length}, libri deselezionati';
        emit(ListaLibroLoadedState(lstSelectedItem, msg));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // on<RefreshLibroEvent>((event, emit) async {
    //   emit(const LibroWaitingState());
    //   try {
    //     final List<SelectedItem<LibroViewModel>> lstSelectedItem = event.lstSelectedItem;
    //     emit(ListaLibroLoadedState(lstSelectedItem, 'Refresh lista libri'));
    //   } catch (e) {
    //     emit(LibroErrorState(e.toString()));
    //   }
    // });

    // ** EXPORT ALL LIBRI LIBRERIA
    on<ExportAllLibriLibreriaEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        final List<LibroIsarModel> lstLibroView = await _dbLibroService.readLstLibroFromDb(event.libreriaIsarModel);
        int nrRecordExported = await sl<ImportExportService>().exportLibriLibreria('libreria', event.libreriaIsarModel.sigla.toString(), lstLibroView);

        emit(ExportedFileState(nrRecordExported, 'Nr. $nrRecordExported: libri esportati.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** DELETE ALL LIBRI LIBRERIA
    on<DeleteAllLibriLibreriaEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        int nrRecordDeleted = await _dbLibroService.deleteAllLibriLibreria(event.libreriaIsarModel);
        await sl<DbLibreriaIsarService>().setNrLibriInLibreriaInUso(event.libreriaIsarModel.sigla, 0);
        ComArea.nrLibriVisibiliInLista = 0;
        LibroUtils.clearNrLibriCaricatiInCache(ComArea.libreriaInUso!.sigla);

        emit(DeleteAllLibroState(nrRecordDeleted, 'Nr. $nrRecordDeleted: libri eliminati.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** DELETE ALL LIBRI 
    on<DeleteAllLibriEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        int nrRecordDeleted = await _dbLibroService.deleteAllLibri();
        await sl<DbLibreriaIsarService>().setNrLibriInLibreriaInUso(ComArea.libreriaInUso!.sigla, 0);
        ComArea.nrLibriVisibiliInLista = 0;
        LibroUtils.clearNrLibriCaricatiInCache(ComArea.libreriaInUso!.sigla);

        emit(DeleteAllLibroState(nrRecordDeleted, 'Nr. $nrRecordDeleted: libri eliminati.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** ADD
    on<AddLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        event.libroToSaveModel.libroViewModel.dataInserimento = Utils.getDataNow();
        event.libroToSaveModel.libroViewModel.dataUltimaModifica = Utils.getDataNow();
        await _dbLibroService.saveLibroToDb(event.libroToSaveModel, true);
        await sl<DbLibreriaIsarService>().addLibriInLibreriaInUso(event.libroToSaveModel.libroViewModel.siglaLibreria, 1);
        LibroUtils.addNrLibriCaricatiInCache(event.libroToSaveModel.libroViewModel.siglaLibreria);

        ComArea.nrLibriInLibreriaInUso++;
        emit(AddedNewLibroState('Libro ${event.libroToSaveModel.libroViewModel.titolo} caricato in Libreria.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** EDIT
    on<EditLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        int? siglaLibreriaOld = event.libroToSaveModel.siglaLibreriaOld;
        event.libroToSaveModel.libroViewModel.dataUltimaModifica = Utils.getDataNow();
        await _dbLibroService.saveLibroToDb(event.libroToSaveModel, false);
        if (siglaLibreriaOld != null && siglaLibreriaOld != event.libroToSaveModel.libroViewModel.siglaLibreria) {
          await sl<DbLibreriaIsarService>().removeLibroFromLibreriaInUso(siglaLibreriaOld);
          LibroUtils.removeNrLibriCaricatiInCache(siglaLibreriaOld);

          await sl<DbLibreriaIsarService>().addLibriInLibreriaInUso(event.libroToSaveModel.libroViewModel.siglaLibreria, 1);
          LibroUtils.addNrLibriCaricatiInCache(event.libroToSaveModel.libroViewModel.siglaLibreria);
        }
        emit(EditLibroState('Libro ${event.libroToSaveModel.libroViewModel.titolo} modificato.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** DELETE
    on<DeleteLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        await _dbLibroService.deleteLibroToDb(event.libroModelDelete);
        await sl<DbLibreriaIsarService>().removeLibroFromLibreriaInUso(event.libroModelDelete.siglaLibreria);
        ComArea.nrLibriInLibreriaInUso--;
        LibroUtils.removeNrLibriCaricatiInCache(event.libroModelDelete.siglaLibreria);

        // print("=====> ${Constant.libreriaInUso!.nrLibriCaricati}");
        emit(DeletedLibroState('Libro ${event.libroModelDelete.titolo} eliminato.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    on<DeleteBookSelectedEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        int nrDel = 0;
        for (SelectedItem<LibroIsarModel> selectedItem in event.lstSelectedItem) {
          await _dbLibroService.deleteLibroToDb(selectedItem.item);
          await sl<DbLibreriaIsarService>().removeLibroFromLibreriaInUso(selectedItem.item.siglaLibreria);
          
          ComArea.nrLibriInLibreriaInUso--;
          LibroUtils.removeNrLibriCaricatiInCache(selectedItem.item.siglaLibreria);
          nrDel++;
        }

        // print("=====> ${Constant.libreriaInUso!.nrLibriCaricati}");
        emit(DeleteBookSelectedState(nrDel, 'Eliminato nr. $nrDel libri.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });
  }
}