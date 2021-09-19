import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class SingleCard extends StatelessWidget {
  final String recipeName, nutritionScore, price, image, cookTime;

  const SingleCard(
      {Key? key,
      required this.recipeName,
      required this.nutritionScore,
      required this.price,
      required this.image,
      required this.cookTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: 0.5,
          child: Image(image: NetworkImage(image)),
        ),
        FractionallySizedBox(
          alignment: Alignment.centerRight,
          widthFactor: 0.5,
          child: Column(children: [
            // Recipe Name
            Text(
              recipeName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            // Nutrition Score
            RichText(
                text: TextSpan(children: [
              const WidgetSpan(child: Icon(FontAwesome5.apple_alt)),
              TextSpan(text: nutritionScore),
            ])),
            // Price
            RichText(
                text: TextSpan(children: [
              const WidgetSpan(child: Icon(FontAwesome5.dollar_sign)),
              TextSpan(text: price)
            ])),
            // Cook Time
            RichText(
                text: TextSpan(children: [
              const WidgetSpan(child: Icon(FontAwesome5.hourglass)),
              TextSpan(text: cookTime)
            ])),
          ]),
        )
      ]),
    );
  }
}
