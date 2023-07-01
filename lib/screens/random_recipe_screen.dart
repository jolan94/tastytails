import 'package:flutter/material.dart';
import 'package:tastytails/models/recipe.dart';
import 'package:tastytails/utils/api_service.dart';
import 'package:tastytails/utils/local_storage.dart';

class RandomRecipeScreen extends StatefulWidget {
  const RandomRecipeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RandomRecipeScreenState createState() => _RandomRecipeScreenState();
}

class _RandomRecipeScreenState extends State<RandomRecipeScreen> {
  Recipe? recipe;
  bool isLoading = true;
  String errorMessage = '';
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  Future<void> fetchRecipeDetails() async {
    try {
      Recipe fetchedRecipe = await ApiService.fetchRandomRecipe();
      setState(() {
        recipe = fetchedRecipe;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe?.name ?? 'Recipe Details'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(recipe?.image ?? ''),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipe?.name ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipe?.area ?? '',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: recipe?.tags
                                .map((tags) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Chip(
                                        label: Text(tags),
                                        backgroundColor: Colors.amber.shade100,
                                      ),
                                    ))
                                .toList() ??
                            [],
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Instructions:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          recipe!.instructions,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
