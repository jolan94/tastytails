class Recipe {
  final String id;
  final String name;
  final String image;
  final String area;
  final String instructions;
  final List<String> tags;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.area,
    required this.instructions,
    required this.tags,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'],
      name: json['strMeal'],
      image: json['strMealThumb'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      tags: json['strTags'] != null ? json['strTags'].split(',') : [],
    );
  }
}
