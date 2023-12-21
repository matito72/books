class ParameterGoogleSearchModel {
    String? id;
    String? isbn;
    List<String>? filters;
    String? title;
    String? author;
    String? casaEditrice;
    String? genericParam;
    int startIndex = -1;

    ParameterGoogleSearchModel({this.id, this.isbn, this.filters, this.title, this.author, this.casaEditrice, this.genericParam, this.startIndex = 0});
}