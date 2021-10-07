import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'models/meal.dart';
import 'screens/catgory_meals_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> filterdata) {
    setState(() {
      _filters = filterdata;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (filterdata['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (filterdata['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        if (filterdata['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        if (filterdata['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    var index = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (index == -1) {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => mealId == element.id));
      });
    } else {
      setState(() {
        _favoriteMeals.removeAt(index);
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    var index = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (index == -1)
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/', //defalut is /
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
    );
  }
}
