import 'package:books/resources/action_result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ListItemsSelectState extends Equatable {
  final int? nrItemSel;
  final bool? isAllSel;
  final ActionResult? actionResult;

  const ListItemsSelectState({this.nrItemSel, this.isAllSel, this.actionResult});

  @override
  List<Object?> get props => [nrItemSel, isAllSel, actionResult];
}

//* INIT
class ListItemsSelectInitializedState extends ListItemsSelectState {
  const ListItemsSelectInitializedState() : super(nrItemSel: 0, isAllSel: false);
 }

//* REFRESH
class ListItemsSelectRefreshedState extends ListItemsSelectState {
  const ListItemsSelectRefreshedState(int nrItemSel, bool isAllSel) : super(nrItemSel: nrItemSel, isAllSel: isAllSel);
}