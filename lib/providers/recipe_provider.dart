import 'package:flutter/material.dart';
import 'package:tastytails/models/meal.dart';
import 'package:tastytails/models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Meal> _meals = [];

  List<Recipe> get recipes => _recipes;
  List<Meal> get meals => _meals;

  void setRecipes(List<Recipe> recipes) {
    _recipes = recipes;
    notifyListeners();
  }

  void setMeals(List<Meal> meals) {
    _meals = meals;
    notifyListeners();
  }
}
