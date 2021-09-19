import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wouldyourather/Models/Versus_model.dart';

class PromptForQuery extends StatefulWidget {
  const PromptForQuery({Key? key}) : super(key: key);

  @override
  State<PromptForQuery> createState() => _PromptForQueryState();
}

class _PromptForQueryState extends State<PromptForQuery> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final cuisineController = TextEditingController();
  // final mealController = TextEditingController();
  String? _cuisine = "Anything";
  String? _meal = "dinner";

  final List<String> _cuisines = [
    "Anything",
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

  final List<String> _meals = [
    "breakfast",
    "lunch",
    "dinner",
  ];

  final double _fontSize = 30;

  @override
  Widget build(BuildContext context) {
    return Consumer<VersusModel>(
        builder: (context, model, child) => Form(
            key: _formKey,
            child: Container(
                margin: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("I want ",
                              style: TextStyle(fontSize: _fontSize)),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _cuisine,
                              icon: const Icon(Icons.expand_more),
                              iconSize: 16,
                              onChanged: (String? newValue) {
                                setState(() => {_cuisine = newValue});
                              },
                              items: _cuisines
                                  .map<DropdownMenuItem<String>>((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,
                                      style: TextStyle(fontSize: _fontSize)),
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("for ", style: TextStyle(fontSize: _fontSize)),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _meal,
                              icon: const Icon(Icons.expand_more),
                              iconSize: 16,
                              onChanged: (String? newValue) {
                                setState(() => {_meal = newValue});
                              },
                              items: _meals
                                  .map<DropdownMenuItem<String>>((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,
                                      style: TextStyle(fontSize: _fontSize)),
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Center(
                      child: FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/VersusPage");
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
