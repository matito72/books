import 'package:flutter/material.dart';

class  CustomSearchDelegate  extends  SearchDelegate < String > {
   // Elenco fittizio 
  final  List < String > searchList = [
     "Mela" ,
     "Banana" ,
     "Ciliegia" ,
     "Data" ,
     " Fico " ,
     " Uva" ,
     "Kiwi" ,
     "Limone " ,
     "Mango" ,
     "Arancia" ,
     "Papaia" ,
     "Lampone" ,
     "Fragola" ,
     "Pomodoro" ,
     "Anguria" ,
  ]; 

  // Questi metodi sono obbligatori e non puoi saltarli. 

  @override 
  List <Widget> buildActions(BuildContext context) { 
    return [ 
      IconButton( 
        icon: const Icon(Icons.clear), 
        onPressed: () { 
          query = '' ; 
          // Se premuto qui, la query verrà cancellata dalla barra di ricerca.
        }, 
      ), 
    ]; 
  }

  @override
  Widget buildLeading(BuildContext context) { 
    return IconButton( 
      icon: const Icon(Icons.arrow_back), 
      onPressed: () => Navigator.of(context).pop(), 
        // Esci dalla schermata di ricerca.
      ); 
  }

  @override
  Widget buildResults(BuildContext context) { 
    final  List < String > searchResults = searchList 
      .where((item) => item.toLowerCase().contains(query.toLowerCase())) 
      .toList(); 

    return ListView.builder( 
      itemCount: searchResults.length, 
      itemBuilder: (context, index) { 
        return ListTile( 
          title: Text(searchResults[index]), 
          onTap: () { 
            // Gestisce il risultato della ricerca selezionato.
            close(context, searchResults [index]); 
          }, 
        ); 
      }, 
    ); 
  }

  @override
  Widget buildSuggestions(BuildContext context) { 
    final  List < String > suggestionList = query.isEmpty
      ? [] 
      : searchList.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList(); 

    return ListView.builder( 
      itemCount: suggestionList.length, 
      itemBuilder: (context, index) { 
        return ListTile( 
          title: Text(suggestionList[index]), 
          onTap: () { 
            query = suggestionList[index]; 
            // Mostra i risultati della ricerca in base al suggerimento selezionato.
          }, 
        ); 
      }, 
    ); 
  }
}