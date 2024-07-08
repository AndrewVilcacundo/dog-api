import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/api_service.dart';

class PokemonProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Pokemon> _pokemonList = [];
  bool _isLoading = false;

  List<Pokemon> get pokemonList => _pokemonList;
  bool get isLoading => _isLoading;

  Future<void> fetchPokemon() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pokemonList = await _apiService.fetchPokemonList();
    } catch (e) {
      // Handle error
      print('Error fetching Pokémon: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
