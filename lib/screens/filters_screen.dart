import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters';
  final Function _saveFilters;
  final Map<String, bool> _filters;
  const FiltersScreen(this._saveFilters, this._filters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  @override
  initState() {
    super.initState();
    _glutenFree = widget._filters['gluten'] as bool;
    _vegetarian = widget._filters['vegetarian'] as bool;
    _vegan = widget._filters['vegan'] as bool;
    _lactoseFree = widget._filters['lactose'] as bool;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () => widget._saveFilters({
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian
            }),
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  value: _glutenFree,
                  onChanged: (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                  title: Text('Gluten-Free'),
                  subtitle: Text(
                    'Only include gluten-free meals.',
                  ),
                ),
                SwitchListTile(
                  value: _lactoseFree,
                  onChanged: (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                  title: Text('Lactose-Free'),
                  subtitle: Text(
                    'Only include lactose-free meals.',
                  ),
                ),
                SwitchListTile(
                  value: _vegetarian,
                  onChanged: (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                  title: Text('Vegetarian'),
                  subtitle: Text(
                    'Only include vegetarian meals.',
                  ),
                ),
                SwitchListTile(
                  value: _vegan,
                  onChanged: (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                  title: Text('Vegan'),
                  subtitle: Text(
                    'Only include vegan meals.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
