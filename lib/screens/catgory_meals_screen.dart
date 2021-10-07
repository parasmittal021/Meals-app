import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';
  final List<Meal> _availableMeals;
  CategoryMealsScreen(this._availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> categoryMeals;
  bool _initDataLoaded = false;
  void _removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((element) {
        return element.id == mealId;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initDataLoaded) {
      final routeAgrs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeAgrs['title'] as String;
      final String categoryId = routeAgrs['id'] as String;
      categoryMeals = widget._availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _initDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
