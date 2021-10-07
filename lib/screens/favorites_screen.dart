import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;
  FavoritesScreen(this._favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty) {
      return Container(
        child: Center(
          child: Text('You have no favorites yet - Start adding some!'),
        ),
      );
    }
    return  ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _favoriteMeals[index].id,
            title: _favoriteMeals[index].title,
            imageUrl: _favoriteMeals[index].imageUrl,
            duration: _favoriteMeals[index].duration,
            complexity: _favoriteMeals[index].complexity,
            affordability: _favoriteMeals[index].affordability,
          );
        },
        itemCount: _favoriteMeals.length,
      );
  }
}
