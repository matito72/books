
import 'package:books/config/constant.dart';
import 'package:books/features/filtro_libri/bloc/filtro_libri_events.bloc.dart';
import 'package:books/features/filtro_libri/bloc/filtro_libri_state.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltroLibriBloc extends Bloc<FiltroLibriEvent, FiltroLibriState> {
  FiltroLibriState get appBarBlocState => super.state;

  FiltroLibriBloc() : super(const FiltroLibriInitState()) {

    on<FiltroLibriInitEvent>((event, emit) async {
      emit(const FiltroLibriInitState());
    }); 
    
    // ** TEXT
    on<FiltroLibriOrderByEvent>((event, emit) async {
      Constant.setLstBookOrderBy(event.lstOrdinamentoLibri);
      
      emit(FiltroLibriOrderByState(event.lstOrdinamentoLibri));
    }); 
    
    // ** 
    on<FiltroLibriGroupByEvent>((event, emit) async {
      emit(const FiltroLibriGroupByState());
    }); 
    
  }

}