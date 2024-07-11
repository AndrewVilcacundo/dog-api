import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class ApiService {
  final String baseUrl = "https://dog.ceo/api";

  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http.get(Uri.parse('$baseUrl/breeds/list/all'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Pokemon> pokemonList = [];

      // Assuming the response contains breed names
      Map<String, dynamic> breeds = data['message'];
      for (var breed in breeds.keys) {
        var breedDetails = await fetchBreedDetails(breed);
        pokemonList.add(breedDetails);
      }

      return pokemonList;
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  Future<Pokemon> fetchBreedDetails(String breed) async {
    // Fetch breed description and image
    final response = await http.get(Uri.parse('$baseUrl/breed/$breed/images/random'));
    final descriptionResponse = await http.get(Uri.parse('https://example.com/breed/$breed/description'));

    if (response.statusCode == 200 && descriptionResponse.statusCode == 200) {
      final imageData = json.decode(response.body);
      final descriptionData = json.decode(descriptionResponse.body);
      return Pokemon(
        name: breed,
        url: '',
        descripcion: descriptionData['description'] ?? '',
        imagen: imageData['message'] ?? '',
      );
    } else {
      throw Exception('Failed to load breed details');
    }
  }
}
