import 'package:isar/isar.dart';

part 'link_isar.module.g.dart';

@Collection()
class LinkIsarModule {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;
  late String descrizione;

  @Index(unique: true, caseSensitive: true)
  late String url;
  
}