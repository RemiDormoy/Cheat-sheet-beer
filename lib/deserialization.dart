class ReponseGoogleSheet {
  GoogleSheetFeed feed;

  ReponseGoogleSheet(this.feed);

  factory ReponseGoogleSheet.fromJson(Map<String, dynamic> json) {
    return ReponseGoogleSheet(GoogleSheetFeed.fromJson(json['feed']));
  }
}

class GoogleSheetFeed {
  List<GoogleSheetEntry> entry;

  GoogleSheetFeed(this.entry);

  factory GoogleSheetFeed.fromJson(Map<String, dynamic> json) {
    return GoogleSheetFeed(
      (json['entry'] as List)
          .map((yolo) => GoogleSheetEntry.fromJson(yolo))
          .toList(),
    );
  }
}

class GoogleSheetEntry {
  GoogleSheetEntryDetail title;
  GoogleSheetEntryDetail content;

  GoogleSheetEntry({this.title, this.content});

  factory GoogleSheetEntry.fromJson(Map<String, dynamic> json) {
    return GoogleSheetEntry(
      title: GoogleSheetEntryDetail.fromJson(json['title']),
      content: GoogleSheetEntryDetail.fromJson(json['content']),
    );
  }
}

class GoogleSheetEntryDetail {
  String value;

  GoogleSheetEntryDetail(this.value);

  factory GoogleSheetEntryDetail.fromJson(Map<String, dynamic> json) {
    return GoogleSheetEntryDetail(json['\$t']);
  }
}

class Cellule {
  String colonne;
  String ligne;
  String contenu;

  Cellule({this.colonne, this.ligne, this.contenu});
}
