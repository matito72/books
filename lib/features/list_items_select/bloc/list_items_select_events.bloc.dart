import 'package:books/features/libro/data/models/libro_isar.module.dart';
import 'package:books/models/selected_item.module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ListItemsSelectEvent extends Equatable {
  const ListItemsSelectEvent();

  @override
  List<Object?> get props => [];
}

//* INIT
class InitListItemsSelectEvent extends ListItemsSelectEvent { }

class SwitchSearchToUserInsertEvent extends ListItemsSelectEvent { }

class SwitchUserToSearchInsertEvent extends ListItemsSelectEvent { }

//* REFRESH
class RefreshListItemsSelectEvent extends ListItemsSelectEvent {
  final List<SelectedItem<LibroIsarModel>> lstLibroViewModel;

  const RefreshListItemsSelectEvent(this.lstLibroViewModel);
}
