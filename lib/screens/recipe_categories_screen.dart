import 'package:flutter/material.dart';
import 'package:tastytails/models/category.dart';
import 'package:tastytails/screens/favorite_recipes_screen.dart';
import 'package:tastytails/screens/random_recipe_screen.dart';
import 'package:tastytails/screens/recipe_list_screen.dart';
import 'package:tastytails/utils/api_service.dart';

class RecipeCategoriesScreen extends StatefulWidget {
  const RecipeCategoriesScreen({super.key});

  @override
  _RecipeCategoriesScreenState createState() => _RecipeCategoriesScreenState();
}

class _RecipeCategoriesScreenState extends State<RecipeCategoriesScreen> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      List<Category> fetchedCategories = await ApiService.fetchAllCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TastyTails'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 0,
            color: Colors.grey.shade100,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const FavoriteRecipesScreen(),
                          ),
                        );
                      },
                      child: const Text("Favorite Recipe")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const RandomRecipeScreen(),
                          ),
                        );
                      },
                      child: const Text("Random Recipe")),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (ctx, index) {
                  final category = categories[index];
                  return Card(
                    elevation: 0,
                    color: Colors.grey.shade200,
                    child: InkWell(
                      onTap: () {
                        // Navigate to RecipeListScreen for the selected category
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                RecipeListScreen(category: category),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              category.strCategoryThumb,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category.strCategory,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
