import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.saveFilters, this.currentFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _isLactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _isLactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool variable, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: variable,
      subtitle: Text(subtitle),
      onChanged: (value) => updateValue(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _isLactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          // Expanded uses the rest of the screen
          Expanded(
              child: ListView(
            children: [
              _buildSwitchTile(
                  'Gluten-free', 'Only include gluten-free meals', _glutenFree,
                  (value) {
                setState(() {
                  _glutenFree = value;
                });
              }),
              _buildSwitchTile('Lactose-free',
                  'Only include lactose-free meals', _isLactoseFree, (value) {
                setState(() {
                  _isLactoseFree = value;
                });
              }),
              _buildSwitchTile(
                  'Vegetarian', 'Only include vegetarian meals', _vegetarian,
                  (value) {
                setState(() {
                  _vegetarian = value;
                });
              }),
              _buildSwitchTile('Vegan', 'Only include vegan meals', _vegan,
                  (value) {
                setState(() {
                  _vegan = value;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
