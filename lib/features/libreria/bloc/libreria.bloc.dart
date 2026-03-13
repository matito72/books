// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:book/config/com_area.dart';
import 'package:book/features/libreria/bloc/libreria_events.bloc.dart';
import 'package:book/features/libreria/bloc/libreria_state.bloc.dart';
import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:book/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:book/models/selected_item.module.dart';
import 'package:book/utilities/list_items_utils.dart';
import 'package:book/utilities/utils.dart';
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
        List<LibreriaIsarModel> lstLibreriaViewModel = await _dbLibreriaIsarService.readLstLibreriaFromDb();
        List<SelectedItem<LibreriaIsarModel>> lstLibreriaIsarModelSel = ListItemsUtils.convertListToSelectedItems(lstLibreriaViewModel);
        for (SelectedItem<LibreriaIsarModel> selectedItemItem in lstLibreriaIsarModelSel) {
          if (selectedItemItem.item.isLibreriaDefault) {
            selectedItemItem.sel = true;
          }
        }
        ComArea.mapCodDescLibreria = Utils.getMapCodDescLibreria(lstLibreriaViewModel);

        String msg = lstLibreriaViewModel.isEmpty ? 'Nessuna Libreria presente' : 'Nr. ${lstLibreriaViewModel.length} Librerie caricate.';
        emit(LibreriaLoadedState(lstLibreriaIsarModelSel, msg));
      } catch (e) {
        print(e);
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
        await _dbLibreriaIsarService.updateNomeLibreria(event.libreriaIsarModelOld.sigla, event.libreriaIsarModelOld.nome, event.libreriaIsarModelNew.nome);
        emit(EditLibreriaState('Libreria ${event.libreriaIsarModelOld} modificata in ${event.libreriaIsarModelNew}.'));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // SAVE
    on<SaveLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaIsarService.saveLibreria(event.libreriaIsarModelSave);

        List<LibreriaIsarModel> lstLibreriaViewModel = await _dbLibreriaIsarService.readLstLibreriaFromDb();
        List<SelectedItem<LibreriaIsarModel>> lstLibreriaIsarModelSel = ListItemsUtils.convertListToSelectedItems(lstLibreriaViewModel);
        for (SelectedItem<LibreriaIsarModel> selectedItemItem in lstLibreriaIsarModelSel) {
          if (selectedItemItem.item.isLibreriaDefault) {
            selectedItemItem.sel = true;
          }
        }
        ComArea.mapCodDescLibreria = Utils.getMapCodDescLibreria(lstLibreriaViewModel);

        // emit(SaveLibreriaState('Libreria ${event.libreriaIsarModelSave.nome} aggiornata.'));
        String msg = lstLibreriaViewModel.isEmpty ? 'Nessuna Libreria presente' : "Libreria '${event.libreriaIsarModelSave.nome}' aggiornata.";
        emit(LibreriaLoadedState(lstLibreriaIsarModelSel, msg));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });

    // DELETE
    on<DeleteLibreriaEvent>((event, emit) async {
      emit(const LibreriaWaitingState());
      try {
        await _dbLibreriaIsarService.deleteLibreria(event.libreriaIsarModelDelete);
        emit(DeleteLibreriaState('Libreria ${event.libreriaIsarModelDelete.nome} eliminata.'));
      } catch (e) {
        emit(LibreriaErrorState(e.toString()));
      }
    });


  }

}