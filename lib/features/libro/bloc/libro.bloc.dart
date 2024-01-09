import 'package:books/config/com_area.dart';
import 'package:books/config/constant.dart';
import 'package:books/features/import_export/data/services/import_export.service.dart';
import 'package:books/features/libreria/data/services/db_libreria.service.dart';
import 'package:books/features/libro/bloc/libro_events.bloc.dart';
import 'package:books/features/libro/bloc/libro_state.bloc.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:books/features/libro/data/services/db_libro.service.dart';
import 'package:books/injection_container.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:books/utilities/list_items_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibroBloc extends Bloc<LibroEvent, LibroState> {
  final DbLibroService _dbLibroService;

  LibroState get libroBlocState => super.state;

  LibroBloc(this._dbLibroService) : super(const LibroWaitingState()) {

    // ** INIT
    on<InitLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        if (!_dbLibroService.isServiceInitialized()) {
          await _dbLibroService.init();
        }
        
        emit(const LibroInitializedState("Init DB"));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** LOAD
    on<LoadLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        final List<LibroViewModel> lstLibroView = await _dbLibroService.readLstLibroFromDb(event.libreriaModel);
        
        String msg = lstLibroView.isEmpty ? 'Nessun Libro presente' : 'Nr. ${lstLibroView.length}, libri caricati correttamente';
        emit(ListaLibroLoadedState(ListItemsUtils.convertListToSelectedItems(lstLibroView), msg));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    on<CheckAllLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        final List<SelectedItem<LibroViewModel>> lstSelectedItem = event.lstSelectedItem;
        ListItemsUtils.selectedAllItems(lstSelectedItem);
        
        String msg = lstSelectedItem.isEmpty ? 'Nessun Libro selezionato' : 'Nr. ${lstSelectedItem.length}, libri selezionati';
        emit(ListaLibroLoadedState(lstSelectedItem, msg));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    on<DeCheckAllLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        final List<SelectedItem<LibroViewModel>> lstSelectedItem = event.lstSelectedItem;
        ListItemsUtils.deselectedAllItems(lstSelectedItem);
        
        String msg = lstSelectedItem.isEmpty ? 'Nessun Libro deselezionato' : 'Nr. ${lstSelectedItem.length}, libri deselezionati';
        emit(ListaLibroLoadedState(lstSelectedItem, msg));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    on<RefreshLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        final List<SelectedItem<LibroViewModel>> lstSelectedItem = event.lstSelectedItem;
        emit(ListaLibroLoadedState(lstSelectedItem, 'Refresh lista libri'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** EXPORT ALL LIBRI LIBRERIA
    on<ExportAllLibriLibreriaEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        final List<LibroViewModel> lstLibroView = await _dbLibroService.readLstLibroFromDb(event.libreriaModel);
        int nrRecordExported = await sl<ImportExportService>().exportLibriLibreria('libreria', event.libreriaModel.sigla, lstLibroView);

        emit(ExportedFileState(nrRecordExported, 'Nr. $nrRecordExported: libri esportati.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** DELETE ALL LIBRI LIBRERIA
    on<DeleteAllLibriLibreriaEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        int nrRecordDeleted = await _dbLibroService.deleteAllLibriLibreria(event.libreriaModel);
        await sl<DbLibreriaService>().setNrLibriInLibreriaInUso(0);
        ComArea.nrLibriVisibiliInLista = 0;
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
        await sl<DbLibreriaService>().setNrLibriInLibreriaInUso(0);
        ComArea.nrLibriVisibiliInLista = 0;
        emit(DeleteAllLibroState(nrRecordDeleted, 'Nr. $nrRecordDeleted: libri eliminati.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** ADD
    on<AddLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        event.libroModelNew.dataInserimento = Constant.now;
        await _dbLibroService.saveLibroToDb(event.libroModelNew, true);
        await sl<DbLibreriaService>().addLibriInLibreriaInUso(1);
        emit(AddedNewLibroState('Libro ${event.libroModelNew.titolo} caricato in Libreria.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** EDIT
    on<EditLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        await _dbLibroService.saveLibroToDb(event.libroModelEdit, false);
        emit(EditLibroState('Libro ${event.libroModelEdit.titolo} modificato.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** DELETE
    on<DeleteLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
        await _dbLibroService.deleteLibroToDb(event.libroModelDelete);
        await sl<DbLibreriaService>().removeLibroFromLibreriaInUso();

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
        for (SelectedItem selectedItem in event.lstSelectedItem) {
          await _dbLibroService.deleteLibroToDb(selectedItem.item);
          await sl<DbLibreriaService>().removeLibroFromLibreriaInUso();

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