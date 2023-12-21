import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class AppBarEvent extends Equatable {
  const AppBarEvent();

  @override
  List<Object?> get props => [];
}

//* Text-AppBar : DEFAULT
class SwithToTextAppBarEvent extends AppBarEvent { }

//* Search-AppBar
class SwithToSearchAppBarEvent extends AppBarEvent { 
  // final String bookToSearch;
  // const SwithToSearchAppBarEvent(this.bookToSearch);
}