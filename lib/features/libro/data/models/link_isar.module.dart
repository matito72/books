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

  Map<String, dynamic> toJson() => {
    // 'id': id,
    'name': name,
    'descrizione': descrizione,
    'url': url
  };

  LinkIsarModule({
    this.name = '', // Usa i valori predefiniti nel costruttore
    this.descrizione = '',
    this.url = '',
    // Non includere l'ID, Isar lo gestisce
  });

  LinkIsarModule.fromMap(Map<String, dynamic> mappa)
      : name = mappa['name'] as String,
        descrizione = mappa['descrizione'] as String,
        url = mappa['url'] as String {
    // Se la mappa contiene l'ID, assegnamolo (opzionale se l'oggetto viene sempre da Isar)
    if (mappa.containsKey('id')) {
      id = mappa['id'] as Id;
    }
  }

  LinkIsarModule clonaLink() {
    return LinkIsarModule(
      url: url,
      name: name,
      descrizione: descrizione
    );
  }

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