import 'package:books/features/appbar/bloc/appbar_events.bloc.dart';
import 'package:books/features/appbar/bloc/appbar_state.bloc.dart';
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
      
  }

}