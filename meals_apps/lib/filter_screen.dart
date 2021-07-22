import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_apps/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFee = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFee = false;

  Widget _buildSwitchList(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust Your Meal Selection',
                style: Theme.of(context).textTheme.title),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchList(
                  'Glutetn Fee', "Only Include Gluten fee meal", _glutenFee,
                  (newValue) {
                setState(() {
                  _glutenFee = newValue;
                });
              }),
              _buildSwitchList(
                  'Vegetarian Fee', "Only Vegetarian Gluten fee meal", _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchList(
                  'Vegan Fee', "Only Include Vegan fee meal", _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchList(
                  'Lactos Fee', "Only Include Lactose fee meal", _lactoseFee,
                  (newValue) {
                setState(() {
                  _lactoseFee = newValue;
                });
              }),
            ],
          )),
        ],
      ),
    );
  }
}
