import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:word_wheels/backend/services/characters.dart';
import 'dart:convert';

// TODO Make this configurable
final String url = 'http://localhost:8080/characters?page=0&size=3&sort=frequencyRank';

Future<String> getVocabulary() async {
  final response = await http.get(url);
  print(response.body);
  final jsonData = json.decode(response.body);
  final Embedded embedded = Embedded.fromJson(jsonData);
  return embedded.characters.map((element) => element.character).reduce((a, b) => (a + b));
}