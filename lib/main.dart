import 'package:flutter/material.dart';

void main() => runApp(PokemonApp());

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Cards',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: PokemonListPage(),
    );
  }
}

class Pokemon {
  final String name;
  final String type;
  final String imageUrl;
  final String description;
  final int hp;
  final int attack;
  final int rarity;
  bool isFavorite;

  Pokemon({
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.description,
    required this.hp,
    required this.attack,
    required this.rarity,
    this.isFavorite = false, // Default is false (not a favorite)
  });
}

final List<Pokemon> pokemonList = [
  Pokemon(
    name: 'Pikachu',
    type: 'Electric',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
    description: 'Pikachu stores electricity in its cheeks and releases it in lightning-based attacks.',
    hp: 35,
    attack: 55,
    rarity: 4,
  ),
  Pokemon(
    name: 'Charmander',
    type: 'Fire',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
    description: 'Charmander has a flame at the tip of its tail which shows its life force.',
    hp: 39,
    attack: 52,
    rarity: 3,
  ),
  Pokemon(
    name: 'Squirtle',
    type: 'Water',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png',
    description: 'Squirtle uses its shell to protect itself and spray water at enemies.',
    hp: 44,
    attack: 48,
    rarity: 2,
  ),
  Pokemon(
    name: 'Bulbasaur',
    type: 'Grass',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
    description: 'Bulbasaur can absorb sunlight and grow stronger thanks to the bulb on its back.',
    hp: 45,
    attack: 49,
    rarity: 3,
  ),
  Pokemon(
    name: 'Jigglypuff',
    type: 'Fairy',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png',
    description: 'Jigglypuff puts enemies to sleep with its soothing singing voice.',
    hp: 115,
    attack: 45,
    rarity: 2,
  ),
  Pokemon(
    name: 'Meowth',
    type: 'Normal',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/52.png',
    description: 'Meowth is known for collecting shiny coins and walking on two legs.',
    hp: 40,
    attack: 45,
    rarity: 2,
  ),
  Pokemon(
    name: 'Psyduck',
    type: 'Water',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/54.png',
    description: 'Psyduck suffers from headaches and releases psychic waves when stressed.',
    hp: 50,
    attack: 52,
    rarity: 3,
  ),
  Pokemon(
    name: 'Machop',
    type: 'Fighting',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/66.png',
    description: 'Machop loves to train its muscles and is incredibly strong for its size.',
    hp: 70,
    attack: 80,
    rarity: 3,
  ),
  Pokemon(
    name: 'Abra',
    type: 'Psychic',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/63.png',
    description: 'Abra sleeps for 18 hours a day and uses teleportation to escape threats.',
    hp: 25,
    attack: 20,
    rarity: 4,
  ),
  Pokemon(
    name: 'Gengar',
    type: 'Ghost',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png',
    description: 'Gengar hides in shadows and causes a chill with its sinister presence.',
    hp: 60,
    attack: 65,
    rarity: 5,
  ),
];

class PokemonListPage extends StatefulWidget {
  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  List<Pokemon> displayedList = pokemonList;
  TextEditingController _searchController = TextEditingController();

  void _filterPokemon(String query) {
    final results = pokemonList.where((pokemon) {
      return pokemon.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedList = results;
    });
  }

  void _toggleFavorite(Pokemon pokemon) {
    setState(() {
      pokemon.isFavorite = !pokemon.isFavorite;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemon Cards')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterPokemon,
              decoration: InputDecoration(
                hintText: 'Search Pokemon...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedList.length,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final pokemon = displayedList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailPage(pokemon: pokemon),
                      ),
                    );
                  },
                  child: _buildPokemonCard(pokemon),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(),
                ),
              );
            },
            child: Text('View Favorites'),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonCard(Pokemon pokemon) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(pokemon.imageUrl, width: 80, height: 80),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      _buildTypeBadge(pokemon.type),
                      SizedBox(width: 8),
                      _buildStatIcon(Icons.favorite, '${pokemon.hp} HP', Colors.red),
                      SizedBox(width: 8),
                      _buildStatIcon(Icons.flash_on, '${pokemon.attack} ATK', Colors.orange),
                    ],
                  ),
                  SizedBox(height: 6),
                  _buildStars(pokemon.rarity),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: pokemon.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () => _toggleFavorite(pokemon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _typeColor(type),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(type, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _buildStatIcon(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildStars(int count) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          size: 16,
          color: index < count ? Colors.amber : Colors.grey[300],
        ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Electric':
        return Colors.amber;
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Filter the list to show only favorite Pokémon
    final favoritePokemonList = pokemonList.where((pokemon) => pokemon.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Pokemon')),
      body: favoritePokemonList.isEmpty
          ? Center(child: Text('No favorites yet!'))
          : ListView.builder(
              itemCount: favoritePokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = favoritePokemonList[index];
                return PokemonCard(pokemon: pokemon);
              },
            ),
    );
  }
}

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailPage({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.network(pokemon.imageUrl, height: 120),
                ),
                SizedBox(height: 20),
                Text(
                  pokemon.name,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _typeColor(pokemon.type),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    pokemon.type,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatIcon(Icons.favorite, '${pokemon.hp} HP', Colors.red),
                    SizedBox(width: 16),
                    _buildStatIcon(Icons.flash_on, '${pokemon.attack} ATK', Colors.orange),
                  ],
                ),
                SizedBox(height: 16),
                _buildStars(pokemon.rarity),
                SizedBox(height: 20),
                Text(
                  pokemon.description,
                  style: TextStyle(fontSize: 16, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildStars(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          size: 20,
          color: index < count ? Colors.amber : Colors.grey[300],
        ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Electric':
        return Colors.amber;
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(pokemon.imageUrl, width: 60, height: 60),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      _buildTypeBadge(pokemon.type),
                      SizedBox(width: 8),
                      _buildStatIcon(Icons.favorite, '${pokemon.hp} HP', Colors.red),
                      SizedBox(width: 8),
                      _buildStatIcon(Icons.flash_on, '${pokemon.attack} ATK', Colors.orange),
                    ],
                  ),
                  SizedBox(height: 6),
                  _buildStars(pokemon.rarity),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: pokemon.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _typeColor(type),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(type, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _buildStatIcon(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildStars(int count) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          size: 16,
          color: index < count ? Colors.amber : Colors.grey[300],
        ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Electric':
        return Colors.amber;
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}