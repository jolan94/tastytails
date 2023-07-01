import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastytails/models/recipe.dart';
import 'package:tastytails/utils/api_service.dart';
import 'package:tastytails/screens/recipe_details_screen.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  const FavoriteRecipesScreen();

  @override
  _FavoriteRecipesScreenState createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
  List<String> favoriteRecipeIds = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteRecipeIds();
  }

  Future<void> loadFavoriteRecipeIds() async {
    final prefs = await SharedPreferences.getInstance();
    final storedRecipeIds = prefs.getStringList('favoriteRecipeIds') ?? [];
    setState(() {
      favoriteRecipeIds = storedRecipeIds;
    });
  }

  Future<void> toggleFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final storedRecipeIds = prefs.getStringList('favoriteRecipeIds') ?? [];

    if (storedRecipeIds.contains(recipeId)) {
      storedRecipeIds.remove(recipeId);
    } else {
      storedRecipeIds.add(recipeId);
    }

    setState(() {
      favoriteRecipeIds = storedRecipeIds;
    });

    prefs.setStringList('favoriteRecipeIds', storedRecipeIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipeIds.length,
        itemBuilder: (ctx, index) {
          final recipeId = favoriteRecipeIds[index];
          return FutureBuilder<Recipe>(
            future: ApiService.fetchRecipeDetails(recipeId),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ListTile(
                  title: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return const ListTile(
                  title: Text('Failed to load recipe'),
                );
              } else {
                final recipe = snapshot.data!;
                return Card(
                  child: ListTile(
                    title: Text(recipe.name),
                    leading: Image.network(recipe.image),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                      onPressed: () => toggleFavorite(recipe.id),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) =>
                              RecipeDetailsScreen(mealId: recipeId),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
