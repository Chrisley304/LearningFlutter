import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  // ListTile builder
  Widget buildListTile(String text, IconData icon, Function function) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(text,
          style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 24,
              fontWeight: FontWeight.bold)),
      onTap: () => function(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Cooking up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: 20),
          buildListTile('Meals', Icons.restaurant,
              () => {Navigator.of(context).pushReplacementNamed('/')}),
          buildListTile(
              'Filters',
              Icons.settings,
              () => {
                    Navigator.of(context)
                        .pushReplacementNamed(FilterScreen.routeName)
                  }),
        ],
      ),
    );
  }
}
