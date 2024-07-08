import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/pokemon_provider.dart';
import 'models/pokemon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter PokeAPI Demo',
        home: PokemonListScreen(),
      ),
    );
  }
}

class PokemonListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Razas de Perros'),
      ),
      body: pokemonProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pokemonProvider.pokemonList.length,
              itemBuilder: (context, index) {
                Pokemon pokemon = pokemonProvider.pokemonList[index];
                return ListTile(
                  title: Text(pokemon.name),
                  onTap: () {
                    // Add navigation to a Pokémon detail screen here if needed
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pokemonProvider.fetchPokemon();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
