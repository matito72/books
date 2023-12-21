import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class AppBarState<T> extends Equatable {
  const AppBarState();

  @override
  List<Object?> get props => [];
}

//* TEXT
class TextAppBarState extends AppBarState {
  const TextAppBarState() : super();
}

//* SEARCH
class SearchAppBarState extends AppBarState {
  const SearchAppBarState() : super();
}