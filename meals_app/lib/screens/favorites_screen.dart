import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritesMeals;

  FavoritesScreen(this.favoritesMeals);

  @override
  Widget build(BuildContext context) {
    if (favoritesMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet - Start adding some! '),
      );
    } else {
      return ListView.builder(
        itemBuilder: (cxt, index) {
          return MealItem(
              title: favoritesMeals[index].title,
              imageUrl: favoritesMeals[index].imageUrl,
              duration: favoritesMeals[index].duration,
              complexity: favoritesMeals[index].complexity,
              affordability: favoritesMeals[index].affordability,
              id: favoritesMeals[index].id);
        },
        itemCount: favoritesMeals.length,
      );
    }
  }
}
