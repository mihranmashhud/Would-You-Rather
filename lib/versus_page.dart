import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wouldyourather/Models/Versus_model.dart';
import 'package:provider/provider.dart';
import "package:hop_swipe_cards/hop_swipe_cards.dart";
import 'package:fluttericon/font_awesome5_icons.dart';

class VersusPage extends StatefulWidget {
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
    return Stack(
      children: [
        Container(),
        Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                child: HopSwipeCards(
                    cardBuilder: (context, index, a, b) => _SingleCard,
                    totalNum: 2))
          ],
        ),
      ],
    );
  }
}

class _SingleCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingleCardState();
}

class _SingleCardState extends State<_SingleCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VersusPage>(
      builder: (context, model, child) => Card(
        child: Row(children: [
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.5,
            child: Image(image: NetworkImage(model.image)),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: 0.5,
            child: Column(children: [
              // Recipe Name
              Text(
                model.recipeName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              // Nutrition Score
              RichText(
                  text: TextSpan(children: [
                WidgetSpan(child: Icon(FontAwesome5.apple_alt)),
                TextSpan(text: Text(model.nutritionScore))
              ])),
              // Price
              RichText(
                  text: TextSpan(children: [
                WidgetSpan(child: Icon(FontAwesome5.dollar_sign)),
                TextSpan(text: Text(model.price))
              ])),
              // Cook Time
              RichText(
                  text: TextSpan(children: [
                WidgetSpan(child: Icon(FontAwesome5.hourglass)),
                TextSpan(text: Text(model.cookTime))
              ])),
            ]),
          )
        ]),
      ),
    );
  }
}
