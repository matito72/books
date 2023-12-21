import 'package:books/config/constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class FiltroLibriState<T> extends Equatable {
  const FiltroLibriState();

  @override
  List<Object?> get props => [];
}

//* WAIT
class FiltroLibriInitState extends FiltroLibriState {
  const FiltroLibriInitState() : super();
}

//* REFRESH TITLE
class FiltroLibriOrderByState extends FiltroLibriState {
  final List<OrdinamentoLibri> lstOrdinamentoLibri;
  const FiltroLibriOrderByState(this.lstOrdinamentoLibri) : super();
}

class FiltroLibriGroupByState extends FiltroLibriState {
  const FiltroLibriGroupByState() : super();
}