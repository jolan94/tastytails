import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytails/models/category.dart';
import 'package:tastytails/models/meal.dart';
import 'package:tastytails/models/recipe.dart';
import 'package:tastytails/providers/recipe_provider.dart';
import 'package:tastytails/screens/recipe_details_screen.dart';
import 'package:tastytails/utils/api_service.dart';

class RecipeListScreen extends StatefulWidget {
  final Category category;

  const RecipeListScreen({Key? key, required this.category}) : super(key: key);

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Meal> meals = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Fetch meals for the selected category using API
    fetchMealsByCategory(widget.category.strCategory);
  }

  Future<void> fetchMealsByCategory(String category) async {
    try {
      List<Meal> fetchedMeals = await ApiService.fetchMealsByCategory(category);
      setState(() {
        meals = fetchedMeals;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch meals';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.strCategory),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage),
                )
              : ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (ctx, index) {
                    final meal = meals[index];
                    return Card(
                      elevation: 0,
                      color: Colors.grey.shade100,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(meal.strMeal),
                        leading: Image.network(meal.strMealThumb),
                        onTap: () {
                          // Navigate to RecipeDetailsScreen for the selected recipe
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => RecipeDetailsScreen(
                                mealId: meals[index].idMeal,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
