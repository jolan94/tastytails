import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<List<String>> getFavoriteRecipeIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favoriteRecipeIds') ?? [];
  }

  static Future<void> addFavoriteRecipeId(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRecipeIds = await getFavoriteRecipeIds();
    favoriteRecipeIds.add(recipeId);
    prefs.setStringList('favoriteRecipeIds', favoriteRecipeIds);
  }

  static Future<void> removeFavoriteRecipeId(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRecipeIds = await getFavoriteRecipeIds();
    favoriteRecipeIds.remove(recipeId);
    prefs.setStringList('favoriteRecipeIds', favoriteRecipeIds);
  }
}
