import 'package:books/config/constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class FiltroLibriEvent extends Equatable {
  const FiltroLibriEvent();

  @override
  List<Object?> get props => [];
}

class FiltroLibriInitEvent extends FiltroLibriEvent { }

class FiltroLibriOrderByEvent extends FiltroLibriEvent { 
  final List<OrdinamentoLibri> lstOrdinamentoLibri;

  const FiltroLibriOrderByEvent(this.lstOrdinamentoLibri);  
}

class FiltroLibriGroupByEvent extends FiltroLibriEvent { }