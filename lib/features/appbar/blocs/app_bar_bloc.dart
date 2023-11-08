import 'package:books/features/appbar/blocs/app_bar_events.dart';
import 'package:books/features/appbar/blocs/app_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarState get appBarBlocState => super.state;

    AppBarBloc() : super(const TextAppBarState()) {
    
    // ** TEXT
    on<SwithToTextAppBarEvent>((event, emit) async {
      emit(const TextAppBarState());
    }); 

    // ** SEARCH
    on<SwithToSearchAppBarEvent>((event, emit) async {
      emit(const SearchAppBarState());
    }); 

    // ** REFRESH
    on<RefreshAppBarEvent>((event, emit) async {
      emit(const RefreshAppBarState());
    }); 
  }

}