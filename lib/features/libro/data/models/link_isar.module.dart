import 'package:isar_community/isar.dart';

part 'link_isar.module.g.dart';

@Collection()
class LinkIsarModule {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;
  late String descrizione;

  @Index(unique: true, caseSensitive: true)
  late String url;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LinkIsarModule &&
        other.name == name &&
        other.descrizione == descrizione &&
        other.url == url;
  }

  @override
  int get hashCode => Object.hash(name, descrizione, url);
}