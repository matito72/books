import 'package:books/features/libreria/bloc/libreria_events.bloc.dart';
import 'package:books/features/libreria/bloc/libreria_state.bloc.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:books/utilities/list_items_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibreriaBloc extends Bloc<LibreriaEvent, LibreriaState> {
  final DbLibreriaIsarService _dbLibreriaIsarService;
  
  LibreriaBloc(this._dbLibreriaIsarService) : super(const LibreriaWaitingState()) {

    // ** INIT
    on<InitLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        // await _dbLibreriaIsarService.init();
        emit(const LibreriaInitializedState("Init DB"));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // ** LOAD
    on<LoadLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        // while (!_dbLibreriaIsarService.isServiceInitialized() ) {
        //     await Future.delayed(const Duration(seconds: 1));
        // }
        List<LibreriaIsarModel> lstLibreriaViewModel = await _dbLibreriaIsarService.readLstLibreriaFromDb();
        List<SelectedItem<LibreriaIsarModel>> lstLibreriaIsarModelSel = ListItemsUtils.convertListToSelectedItems(lstLibreriaViewModel);
        for (SelectedItem<LibreriaIsarModel> selectedItemItem in lstLibreriaIsarModelSel) {
          if (selectedItemItem.item.isLibreriaDefault) {
            selectedItemItem.sel = true;
            // ComArea.libreriaInUso = selectedItemItem.item;
          }
        }
        // if (lstLibreriaViewModel.isLibreriaDefault) {
        //   ComArea.libreriaInUso = libreriaToAdd;
        // }
        String msg = lstLibreriaViewModel.isEmpty ? 'Nessuna Libreria presente' : 'Nr. ${lstLibreriaViewModel.length} Librerie caricate correttamente';
        emit(LibreriaLoadedState(lstLibreriaIsarModelSel, msg));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // ** ADD
    on<AddLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaIsarService.insertLibreria(event.libreriaIsarModelNew);
        emit(AddedNewLibreriaState('Nuova libreria ${event.libreriaIsarModelNew.nome} inserita.'));        
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // EDIT
    on<EditLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaIsarService.updateLibreria(event.libreriaIsarModelNew);
        emit(EditLibreriaState('Libreria ${event.libreriaIsarModelOld} modificata in ${event.libreriaIsarModelNew} correttamente.'));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // DELETE
    on<DeleteLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaIsarService.deleteLibreria(event.libreriaIsarModelDelete);
        emit(DeleteLibreriaState('Libreria ${event.libreriaIsarModelDelete.nome} eliminata correttamente'));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // //! RESET -> DELETE-ALL
    // on<DeleteAllLibreriaEvent>((event, emit) async {
    //   emit(const LibreriaWaitingState());
    //   try {
    //     int nrRecordDeleted = await _dbLibreriaIsarService.deleteAllLibrerie();
    //     emit(DeleteAllLibreriaState(nrRecordDeleted, 'Nr. $nrRecordDeleted: librerie eliminate.'));
    //   } catch (e) {
    //     emit(LibreriaErrorState(e.toString()));
    //   }
    // });
  }

}