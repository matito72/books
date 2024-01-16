/// BISAC Subject Headings List
/// https://www.bisg.org/complete-bisac-subject-headings-list
/// 
class BisacList {
  static const String nonClassifiable = "NON-CLASSIFIABLE";

  static List<String> lstBisacCods = [
    'ANTIQUES & COLLECTIBLES', 
    'ARCHITECTURE', 
    'ART', 
    'BIBLES', 
    'BIOGRAPHY & AUTOBIOGRAPHY', 
    'BODY, MIND & SPIRIT', 
    'BUSINESS & ECONOMICS', 
    'COMICS & GRAPHIC NOVELS', 
    'COMPUTERS', 
    'COOKING', 
    'CRAFTS & HOBBIES', 
    'DESIGN', 
    'DRAMA', 
    'EDUCATION', 
    'FAMILY & RELATIONSHIPS', 
    'FICTION', 
    'FOREIGN LANGUAGE STUDY', 
    'GAMES & ACTIVITIES', 
    'GARDENING', 
    'HEALTH & FITNESS', 
    'HISTORY', 
    'HOUSE & HOME', 
    'HUMOR', 
    'JUVENILE FICTION', 
    'JUVENILE NONFICTION', 
    'LANGUAGE ARTS & DISCIPLINES', 
    'LAW', 
    'LITERARY COLLECTIONS', 
    'LITERARY CRITICISM', 
    'MATHEMATICS', 
    'MEDICAL', 
    'MUSIC', 
    'NATURE', 
    'PERFORMING ARTS', 
    'PETS', 
    'PHILOSOPHY', 
    'PHOTOGRAPHY', 
    'POETRY', 
    'POLITICAL SCIENCE', 
    'PSYCHOLOGY', 
    'REFERENCE', 
    'RELIGION', 
    'SCIENCE', 
    'SELF-HELP', 
    'SOCIAL SCIENCE', 
    'SPORTS & RECREATION', 
    'STUDY AIDS', 
    'TECHNOLOGY & ENGINEERING', 
    'TRANSPORTATION', 
    'TRAVEL', 
    'TRUE CRIME', 
    'YOUNG ADULT FICTION', 
    'YOUNG ADULT NONFICTION',
    nonClassifiable,
  ];

  Map<String, String> mapBisacCodeTransate = {
    'ANTIQUES & COLLECTIBLES': 'ANTIQUARIATO E COLLEZIONISMO',
    'ARCHITECTURE': 'ARCHITETTURA',
    'ART': 'ARTE',
    'BIBLES': 'BIBBIE',
    'BIOGRAPHY & AUTOBIOGRAPHY': 'BIOGRAFIA E AUTOBIOGRAFIA',
    'BODY, MIND & SPIRIT': 'CORPO, MENTE E SPIRITO',
    'BUSINESS & ECONOMICS': 'BUSINESS ED ECONOMIA',
    'COMICS & GRAPHIC NOVELS': 'FUMETTI E GRAPHIC NOVEL',
    'COMPUTERS': "COMPUTER",
    'COOKING': 'CUCINANDO',
    'CRAFTS & HOBBIES': 'ARTIGIANATO E HOBBY',
    'DESIGN': 'PROGETTO',
    'DRAMA': 'DRAMMA',
    'EDUCATION': 'FORMAZIONE SCOLASTICA',
    'FAMILY & RELATIONSHIPS': 'RELAZIONI FAMILIARI',
    'FICTION': 'FANTASIA',
    'FOREIGN LANGUAGE STUDY': 'STUDI DELLA LINGUA STRANIERA',
    'GAMES & ACTIVITIES': 'GIOCHI E ATTIVITÀ',
    'GARDENING': 'GIARDINAGGIO',
    'HEALTH & FITNESS': 'SALUTE E FITNESS',
    'HISTORY': 'STORIA',
    'HOUSE & HOME': 'CASA',
    'HUMOR': 'UMORISMO',
    'JUVENILE FICTION': 'Narrativa per ragazzi',
    'JUVENILE NONFICTION': 'Saggistica GIOVANILE',
    'LANGUAGE ARTS & DISCIPLINES': 'ARTI E DISCIPLINE LINGUISTICHE',
    'LAW': 'LEGGE',
    'LITERARY COLLECTIONS': 'RACCOLTE LETTERARI',
    'LITERARY CRITICISM': 'CRITICA LETTERARIA',
    'MATHEMATICS': 'MATEMATICA',
    'MEDICAL': 'MEDICO',
    'MUSIC': 'MUSICA',
    'NATURE': 'NATURA',
    'PERFORMING ARTS': 'ARTI DELLO SPETTACOLO',
    'PETS': "ANIMALI DOMESTICI",
    'PHILOSOPHY': 'FILOSOFIA',
    'PHOTOGRAPHY': 'FOTOGRAFIA',
    'POETRY': 'POESIA',
    'POLITICAL SCIENCE': 'SCIENZE POLITICHE',
    'PSYCHOLOGY': 'PSICOLOGIA',
    'REFERENCE': 'RIFERIMENTO',
    'RELIGION': 'RELIGIONE',
    'SCIENCE': 'SCIENZA',
    'SELF-HELP': 'AUTO-AIUTO',
    'SOCIAL SCIENCE': 'SCIENZE SOCIALI',
    'SPORTS & RECREATION': "SPORT E RICREAZIONE",
    'STUDY AIDS': "SUSSIDI PER LO STUDIO",
    'TECHNOLOGY & ENGINEERING': "TECNOLOGIA E INGEGNERIA",
    'TRANSPORTATION': "TRASPORTO",
    'TRAVEL': 'VIAGGIO',
    'TRUE CRIME': 'VERO CRIMINE',
    'YOUNG ADULT FICTION': 'NARRATIVA PER GIOVANI ADULTI',
    'YOUNG ADULT NONFICTION': 'SAGGISTICA PER GIOVANI ADULTI',
    nonClassifiable: 'NON CLASSIFICABILE'
  };
}