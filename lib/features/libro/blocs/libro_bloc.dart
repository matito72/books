import 'package:books/config/constant.dart';
import 'package:books/features/import_export/data/repository/import_export_service.dart';
import 'package:books/features/libreria/data/repository/db_libreria_service.dart';
import 'package:books/features/libro/blocs/libro_events.dart';
import 'package:books/features/libro/blocs/libro_state.dart';
import 'package:books/features/libro/data/models/libro_view_model.dart';
import 'package:books/features/libro/data/repository/db_libro_service.dart';
import 'package:books/injection_container.dart';
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
        // while (!_dbLibroService.isServiceInitialized()) {
        //     await Future.delayed(const Duration(seconds: 1));
        // }

        final List<LibroViewModel> lstLibroView = await _dbLibroService.readLstLibroFromDb(event.libreriaModel);
        
        String msg = lstLibroView.isEmpty ? 'Nessun Libro presente' : 'Nr. ${lstLibroView.length}, libri caricati correttamente';
        emit(ListaLibroLoadedState(lstLibroView, msg));
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
        emit(DeleteAllLibroState(nrRecordDeleted, 'Nr. $nrRecordDeleted: libri eliminati.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });

    // ** ADD
    on<AddLibroEvent>((event, emit) async {
      emit(const LibroWaitingState());
      try {
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

        print("=====> ${Constant.libreriaInUso!.nrLibriCaricati}");
        emit(DeletedLibroState('Libro ${event.libroModelDelete.titolo} eliminato.'));
      } catch (e) {
        emit(LibroErrorState(e.toString()));
      }
    });
  }

}