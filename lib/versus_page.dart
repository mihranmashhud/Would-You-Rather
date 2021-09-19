// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wouldyourather/Models/versus_model.dart';
import 'package:provider/provider.dart';
import "package:hop_swipe_cards/hop_swipe_cards.dart";
import 'package:wouldyourather/Components/single_card.dart';

class VersusPage extends StatefulWidget {
  const VersusPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VersusPageState();
}

class _VersusPageState extends State<VersusPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Stack(children: [
      Container(),
      Column(
        children: [
          Consumer<VersusModel>(builder: (context, model, child) {
            return SizedBox(
                // height: MediaQuery.of(context).size.height * 0.5,
                child: HopSwipeCards(
                    // ignore: prefer_const_constructors
                    cardBuilder: (context, index, a) => SingleCard(
                          recipeName: model.recipeName,
                          nutritionScore: model.nutritionScore,
                          price: model.price,
                          image: model.image,
                          cookTime: model.cookTime,
                        ),
                    totalNum: 2));
          }),
          Consumer<VersusModel>(builder: (context, model, child) {
            return SizedBox(
                // height: MediaQuery.of(context).size.height * 0.5,
                child: HopSwipeCards(
                    // ignore: prefer_const_constructors
                    cardBuilder: (context, index, a) => SingleCard(
                          recipeName: model.recipeName,
                          nutritionScore: model.nutritionScore,
                          price: model.price,
                          image: model.image,
                          cookTime: model.cookTime,
                        ),
                    totalNum: 2));
          }),
        ],
      ),
    ]);
  }
}
