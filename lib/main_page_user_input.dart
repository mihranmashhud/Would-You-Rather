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
                                  "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.businessinsider.com%2Ftrump-hair-blowing-in-wind-photos-2018-4&psig=AOvVaw37QOrs1kLhnx82tRjgYJAP&ust=1632112923780000&source=images&cd=vfe&ved=0CAgQjRxqFwoTCLDJ082civMCFQAAAAAdAAAAABAD",
                              "price": "\$21",
                              "cookTime": "69 mins"
                            },
                            {
                              "recipeName": "ButterSquash Pie",
                              "nutritionScore": "25%",
                              "image":
                                  "https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.guim.co.uk%2Fimg%2Fmedia%2F5f9f97c5d3d45d74344c65cbaf0ff75b8997c0f8%2F0_114_1707_1024%2Fmaster%2F1707.jpg%3Fwidth%3D1200%26height%3D900%26quality%3D85%26auto%3Dformat%26fit%3Dcrop%26s%3D1b484b722515ca2544a3fc5523c1db70&imgrefurl=https%3A%2F%2Fwww.theguardian.com%2Fus-news%2F2018%2Ffeb%2F07%2Fdonald-trump-hair-wind&tbnid=vzPfif3qS9vXiM&vet=12ahUKEwjHjNvJnIrzAhXLf6wKHRHtB_YQMygFegUIARCEAQ..i&docid=VzqluuIeCSsYtM&w=1200&h=900&q=donald%20trump%27s%20wig%20falling%20off&ved=2ahUKEwjHjNvJnIrzAhXLf6wKHRHtB_YQMygFegUIARCEAQ",
                              "price": "\$56",
                              "cookTime": "23 mins"
                            },
                            {
                              "recipeName": "Jumping Jack Jellybeans",
                              "nutritionScore": "12%",
                              "image":
                                  "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmedia.allure.com%2Fphotos%2F5a7b1ae4a3d9063daae3ca5b%2F2%3A1%2Fw_5472%2Ch_2736%2Cc_limit%2Fdonald-trump-head-exposed.jpg&imgrefurl=https%3A%2F%2Fwww.allure.com%2Fstory%2Fdonald-trump-comb-over-wind&tbnid=R_8uDQCHgbfpwM&vet=12ahUKEwjHjNvJnIrzAhXLf6wKHRHtB_YQMyhFegQIARA3..i&docid=106XXxASdf0k_M&w=5472&h=2736&q=donald%20trump%27s%20wig%20falling%20off&ved=2ahUKEwjHjNvJnIrzAhXLf6wKHRHtB_YQMyhFegQIARA3",
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
