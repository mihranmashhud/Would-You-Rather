import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class SingleCard extends StatefulWidget {
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
  State<StatefulWidget> createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [
        Expanded(
          child: Image(image: NetworkImage(widget.image)),
        ),
        Expanded(
          child: Column(children: [
            // Recipe Name
            Text(
              widget.recipeName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            // Nutrition Score
            RichText(
                text: TextSpan(children: [
              const WidgetSpan(child: Icon(FontAwesome5.apple_alt)),
              TextSpan(text: widget.nutritionScore),
            ])),
            // Price
            RichText(
                text: TextSpan(children: [
              const WidgetSpan(child: Icon(FontAwesome5.dollar_sign)),
              TextSpan(text: widget.price)
            ])),
            // Cook Time
            RichText(
                text: TextSpan(children: [
              const WidgetSpan(child: Icon(FontAwesome5.hourglass)),
              TextSpan(text: widget.cookTime)
            ])),
          ]),
        )
      ]),
    );
  }
}
