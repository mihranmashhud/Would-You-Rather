// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wouldyourather/Models/preferences.dart';
import 'package:http/http.dart' as http;

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List<String> diet_types = [
    "Gluten Free",
    "Ketogenic",
    "Vegetarian",
    "Lacto-Vegetarian",
    "Ovo-Vegetarian",
    "Vegan",
    "Pescetarian",
    "Paleo",
    "Primal",
    "Whole30",
  ];

  List<String> restrictions = [
    "Dairy",
    "Egg",
    "Gluten",
    "Grain",
    "Peanut",
    "Seafood",
    "Sesame",
    "Shellfish",
    "Soy",
    "Sulfite",
    "Tree Nut",
    "Wheat",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<PreferencesModel>(
          builder: (context, preferences, child) => Scaffold(
                appBar: AppBar(
                  title: const Text("Preferences",
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    tooltip: 'Go Back',
                  ),
                ),
                floatingActionButton: FloatingActionButton.large(
                  onPressed: () {

                  },
                  child: const Icon(Icons.save),
                  backgroundColor: Colors.blue,
                ),
                body: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: SafeArea(
                      bottom: false,
                      top: false,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(children: <Widget>[
                            const Text("Max Prep Time:",
                                style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 40.0,
                              child: TextField(
                                  onChanged: (String text) {
                                    if (text == "") {
                                      preferences.maxPrepTime = -1;
                                    } else {
                                      preferences.maxPrepTime = int.parse(text);
                                    }
                                  },
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ]),
                            )
                          ]),
                          SizedBox(height: 10.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(children: <Widget>[
                                const Text("Diet(s):",
                                    style: TextStyle(fontSize: 24)),
                                const SizedBox(height: 10),
                                ToggleButtons(
                                  children: diet_types
                                      .map<Widget>((String diet_type) {
                                    return Text(diet_type,
                                        style: const TextStyle(fontSize: 16));
                                  }).toList(),
                                  onPressed: (int index) {
                                    var dietTypes = preferences.dietTypes;
                                    var diet_type = diet_types[index];
                                    if (dietTypes.contains(diet_type)) {
                                      dietTypes.remove(diet_type);
                                    } else {
                                      dietTypes.add(diet_types[index]);
                                    }
                                    preferences.dietTypes = dietTypes;
                                  },
                                  isSelected:
                                      diet_types.map<bool>((String diet_type) {
                                    return preferences.dietTypes
                                        .contains(diet_type);
                                  }).toList(),
                                  direction: Axis.vertical,
                                )
                              ]),
                              const SizedBox(width: 20),
                              Column(children: <Widget>[
                                const Text("Intolerance(s):",
                                    style: TextStyle(fontSize: 24)),
                                const SizedBox(height: 10),
                                ToggleButtons(
                                  children: restrictions
                                      .map<Widget>((String restriction) {
                                    return Text(restriction,
                                        style: const TextStyle(fontSize: 16));
                                  }).toList(),
                                  onPressed: (int index) {
                                    var old_restrictions =
                                        preferences.restrictions;
                                    var restriction = restrictions[index];
                                    if (old_restrictions
                                        .contains(restriction)) {
                                      old_restrictions.remove(restriction);
                                    } else {
                                      old_restrictions.add(restrictions[index]);
                                    }
                                    preferences.restrictions = old_restrictions;
                                  },
                                  isSelected:
                                      restrictions.map((String restriction) {
                                    return preferences.restrictions
                                        .contains(restriction);
                                  }).toList(),
                                  direction: Axis.vertical,
                                )
                              ]),
                            ],
                          ),
                        ],
                      )),
                ),
              )),
    );
  }
}
