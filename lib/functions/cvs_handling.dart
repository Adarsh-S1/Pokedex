import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class CvsHandling {
  List<String> headers = [
    'name',
    'abilities',
    'attack',
    'defense',
    'height_m',
    'hp',
    'percentage_male',
    'sp_attack',
    'sp_defense',
    'speed',
    'type1',
    'type2',
    'weight_kg',
    'generation',
    'is_legendary',
    'against_bug',
    'against_dark',
    'against_dragon',
    'against_electric',
    'against_fairy',
    'against_fight',
    'against_fire',
    'against_flying',
    'against_ghost',
    'against_grass',
    'against_ground',
    'against_ice',
    'against_normal',
    'against_poison',
    'against_psychic',
    'against_rock',
    'against_steel',
    'against_water'
  ];

  late List<List<dynamic>> rows;

  Future<List<List<dynamic>>> getData() async {
    // Load the CSV file from assets
    final csvData = await rootBundle.loadString('lib/assets/pokemon.csv');
    rows = const CsvToListConverter().convert(csvData);
    return rows;
  }

  Future<Map<String, dynamic>> getRow(String searchValue) async {
    rows = await getData();
    for (var i = 1; i < rows.length; i++) {
      if (rows[i].isNotEmpty && rows[i][0] == searchValue) {
        Map<String, dynamic> jsonRow = {
          for (var j = 0; j < headers.length; j++) headers[j]: rows[i][j]
        };
        return jsonRow;
      }
    }
    return {};
  }

  Map<String, dynamic> getJsonByRow(rowdata) {
    // Check if the index is within the bounds of the CSV file
    if (rowdata.isNotEmpty) {
      // Create a JSON map from headers and row values at the specified index
      Map<String, dynamic> jsonRow = {
        for (var j = 0; j < headers.length; j++) headers[j]: rowdata[j]
      };
      return jsonRow;
    }
    // Return an empty map if the index is out of bounds
    return {};
  }
}
