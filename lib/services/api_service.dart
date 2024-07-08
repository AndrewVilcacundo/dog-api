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
      breeds.forEach((breed, subBreeds) {
        if (subBreeds.isEmpty) {
          pokemonList.add(Pokemon(
            name: breed,
            url: '', // You can set a URL if needed
            descripcion: '', // You can set a description if needed
            imagen: '',
          ));
        } else {
          subBreeds.forEach((subBreed) {
            pokemonList.add(Pokemon(
              name: '$breed $subBreed',
              url: '', // You can set a URL if needed
              descripcion: '', // You can set a description if needed
              imagen: '',
            ));
          });
        }
      });

      return pokemonList;
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}
