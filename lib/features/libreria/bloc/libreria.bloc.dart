// import 'dart:math';

import 'package:books/features/libreria/bloc/libreria_events.bloc.dart';
import 'package:books/features/libreria/bloc/libreria_state.bloc.dart';
import 'package:books/features/libreria/data/models/libreria.module.dart';
import 'package:books/features/libreria/data/services/db_libreria.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibreriaBloc extends Bloc<LibreriaEvent, LibreriaState> {
  final DbLibreriaService _dbLibreriaService;
  
  LibreriaBloc(this._dbLibreriaService) : super(const LibreriaWaitingState()) {

    // ** INIT
    on<InitLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaService.init();
        emit(const LibreriaInitializedState("Init DB"));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // ** LOAD
    on<LoadLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        while (!_dbLibreriaService.isServiceInitialized() ) {
            await Future.delayed(const Duration(seconds: 1));
        }
        List<LibreriaModel> lstLibreriaViewModel = await _dbLibreriaService.readLstLibreriaFromDb();
        String msg = lstLibreriaViewModel.isEmpty ? 'Nessuna Libreria presente' : 'Nr. ${lstLibreriaViewModel.length} Librerie caricate correttamente';
        emit(LibreriaLoadedState(lstLibreriaViewModel, msg));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // ** ADD
    on<AddLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaService.insertLibreria(event.libreriaModelNew);
        emit(AddedNewLibreriaState('Nuova libreria ${event.libreriaModelNew.nome} inserita.'));        
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // EDIT
    on<EditLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaService.updateLibreria(event.libreriaModelOld, event.libreriaModelNew);
        emit(EditLibreriaState('Libreria ${event.libreriaModelOld} modificata in ${event.libreriaModelNew} correttamente.'));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // DELETE
    on<DeleteLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaService.deleteLibreria(event.libreriaModelDelete);
        emit(DeleteLibreriaState('Libreria ${event.libreriaModelDelete.nome} eliminata correttamente'));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    //! RESET -> DELETE-ALL
    on<DeleteAllLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        int nrRecordDeleted = await _dbLibreriaService.deleteAllLibrerie();
        emit(DeleteAllLibreriaState(nrRecordDeleted, 'Nr. $nrRecordDeleted: librerie eliminate.'));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });
  }

}