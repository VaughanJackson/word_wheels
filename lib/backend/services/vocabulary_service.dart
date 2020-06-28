import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:word_wheels/backend/services/characters.dart';

// TODO Make this configurable
final String url = 'http://localhost:8080/characters?page=0&size=100&sort=frequencyRank';

Future<String> getVocabulary() async {
  print('getVocabulary()');
  final response = await http.get(url);
  // TODO What we get here is not really a character but a page of characters.
  // Can we align the abstractions with what we think we're actually doing at some point?
  final Character character = characterFromJson(response.body);
  return character.embedded.characters.map((element) => element.character).reduce((a, b) => (a + b));
}