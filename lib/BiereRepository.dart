import 'dart:convert';

import 'package:cheatsheetbeer/biere.dart';
import 'package:http/http.dart' as http;

import 'deserialization.dart';

class BiereRepository {
  static BiereRepository _instance;

  static BiereRepository getInstance() {
    if (_instance == null) {
      _instance = BiereRepository();
    }
    return _instance;
  }

  List<Biere> _bieres = [];

  Future<List<Biere>> getBieres() async {
    if (_bieres.isNotEmpty) return _bieres;
    var response = await http.get(
        "https://spreadsheets.google.com/feeds/cells/1AcLXB2zp8-o-2Q9Y168dLaUJigr2rHm6Om3EgIOe5sw/1/public/full?alt=json");
    if (response.statusCode == 200) {
      print("response ok");
      var body = ReponseGoogleSheet.fromJson(json.decode(response.body));
      var cells = body.feed.entry
          .map((entry) => Cellule(
              colonne: entry.title.value.substring(0, 1),
              ligne: entry.title.value.substring(1, entry.title.value.length),
              contenu: entry.content.value))
          .toList();
      Map<String, Map<String, String>> cellsMap = {};
      cells.forEach((cell) => _ajoutCelluleAMap(cell, cellsMap));
      print(cellsMap);
      _bieres = cellsMap.values
          .map((ligne) => Biere(
                ligne["A"],
                ligne["B"],
                ligne["C"],
                ligne["D"],
                ligne["E"],
                ligne["F"],
              ))
          .toList();
    } else {
      return [];
    }
    return _bieres;
  }

  _ajoutCelluleAMap(Cellule cellule, Map<String, Map<String, String>> mapCellules) {
    if (cellule.ligne == "1") return;
    if (mapCellules[cellule.ligne] == null) mapCellules[cellule.ligne] = {};
    mapCellules[cellule.ligne][cellule.colonne] = cellule.contenu;
  }
}
