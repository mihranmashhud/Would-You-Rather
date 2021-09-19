import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wouldyourather/Models/versus_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

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

  // Future<List<Map<String, dynamic>>> getRecipeList(
  //     String cuisine, String meal) async {
  //   Response jsonReponse = await get('');
  //   List<Map<String, dynamic>> response = jsonDecode(jsonReponse.body);
  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Consumer<VersusModel>(
            builder: (context, model, child) => Container(
                margin: const EdgeInsets.all(20.0),
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
                        // TODO: Turn back into async
                        onPressed: () {
                          // TODO: Add backend api url
                          // Response jsonReponse = await get('');
                          // List<Map<String, dynamic>> response =
                          //     jsonDecode(jsonReponse.body);
                          List<Map<String, dynamic>> response = [
                            {
                              "recipeName": "Chunky Pizza",
                              "nutritionScore": "69%",
                              "image":
                                  "https://i.insider.com/5ac6672d524c4a1c008b47d4?width=700&format=jpeg&auto=webp",
                              "price": "\$21",
                              "cookTime": "69 mins"
                            },
                            {
                              "recipeName": "ButterSquash Pie",
                              "nutritionScore": "25%",
                              "image":
                                  "https://media.allure.com/photos/5a7b1ae4a3d9063daae3ca5b/2:1/w_5472,h_2736,c_limit/donald-trump-head-exposed.jpg",
                              "price": "\$56",
                              "cookTime": "23 mins"
                            },
                            {
                              "recipeName": "Monkey Pizza",
                              "nutritionScore": "629%",
                              "image":
                                  "https://i.insider.com/5ac6672d524c4a1c008b47d4?width=700&format=jpeg&auto=webp",
                              "price": "\$23421",
                              "cookTime": "64234239 mins"
                            },
                            {
                              "recipeName": "Jumping Jack Jellybeans",
                              "nutritionScore": "12%",
                              "image":
                                  "https://media.allure.com/photos/5a7b1ae4a3d9063daae3ca5b/2:1/w_5472,h_2736,c_limit/donald-trump-head-exposed.jpg",
                              "price": "\$7",
                              "cookTime": "2 mins"
                            },
                          ];
                          model.jsonResponse = response;
                          print(model.jsonResponse);
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
