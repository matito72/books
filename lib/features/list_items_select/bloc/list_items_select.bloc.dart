
import 'package:books/features/list_items_select/bloc/list_items_select_events.bloc.dart';
import 'package:books/features/list_items_select/bloc/list_items_select_state.bloc.dart';
import 'package:books/utilities/list_items_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListItemsSelectBloc extends Bloc<ListItemsSelectEvent, ListItemsSelectState> {
  
  ListItemsSelectBloc() : super(const ListItemsSelectInitializedState()) {

    on<InitListItemsSelectEvent>((event, emit) async {
      emit(const ListItemsSelectInitializedState());
    });
    
    on<RefreshListItemsSelectEvent>((event, emit) async {
      bool isAllSel = false;
      int nrItemSel = 0;

      if (event.lstLibroViewModel.isNotEmpty) {
        bool isThereOneSelected = ListItemsUtils.isThereOneSelected(event.lstLibroViewModel);
        bool areAllSelected = ListItemsUtils.areAllSelected(event.lstLibroViewModel);
        if (areAllSelected) {
          isAllSel = true;
          nrItemSel = event.lstLibroViewModel.length;
        } else if (isThereOneSelected) {
          nrItemSel = ListItemsUtils.countSelectedItems(event.lstLibroViewModel);
        }
      }
      emit(ListItemsSelectRefreshedState(nrItemSel, isAllSel));
    });

  }

}