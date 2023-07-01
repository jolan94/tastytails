//Take URL data from this site
String webPage = 'https://www.themealdb.com/api.php';

//Fetch All Categories
String fetchAllCategories =
    'https://www.themealdb.com/api/json/v1/1/categories.php';

//Fetch Meals in one Category
String fetchMealsInCategory =
    'https://www.themealdb.com/api/json/v1/1/filter.php?c="categoryId"';
//Change CategoryId in double quotes

//Fetch Recipe using a Meal ID
String fetchRecipeWithId =
    'https://www.themealdb.com/api/json/v1/1/lookup.php?i="recipeId"';
//Change recipeId in double quotes

//Fetch Random Recipe
String fetchRandomRecipes =
    'https://www.themealdb.com/api/json/v1/1/random.php';
