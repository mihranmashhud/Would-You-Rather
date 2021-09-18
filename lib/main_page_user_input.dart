import 'package:flutter/material.dart';

class PromptForQuery extends StatefulWidget {
  const PromptForQuery({Key? key}) : super(key: key);

  @override
  State<PromptForQuery> createState() => _PromptForQuery();
}

class _PromptForQuery extends State<PromptForQuery> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final cuisineController = TextEditingController();
  // final mealController = TextEditingController();
  String? _cuisine = "";
  String? _meal = "";

  final List<String> _cuisines = [
      "",
      "African",
      "American",
      "British",
      "Cajun",
      "Caribbean",
      "Chinese",
      "Eastern European",
      "European",
      "French",
      "German",
      "Greek",
      "Indian",
      "Irish",
      "Italian",
      "Japanese",
      "Jewish",
      "Korean",
      "Latin American",
      "Mediterranean",
      "Mexican",
      "Middle Eastern",
      "Nordic",
      "Southern",
      "Spanish",
      "Thai",
      "Vietnamese",
  ];

  var _meals = [
    "",
    "breakfast",
    "lunch",
    "dinner",
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("I want "),
              DropdownButton<String>(
                value: _cuisine,
                icon: const Icon(Icons.expand_more),
                iconSize: 16,
                underline: Container(height: 2),
                onChanged: (String? newValue) {
                  setState(() => {
                    _cuisine = newValue
                  });
                },
                items: _cuisines.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
              ),
              Text(" for "),
              DropdownButton<String>(
                value: _meal,
                icon: const Icon(Icons.expand_more),
                iconSize: 16,
                underline: Container(height: 2),
                onChanged: (String? newValue) {
                  setState(() => {
                    _meal = newValue
                  });
                },
                items: _meals.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
              ),
              Text("."),
            ]
          )
        ],
      )
    );
  }
}
