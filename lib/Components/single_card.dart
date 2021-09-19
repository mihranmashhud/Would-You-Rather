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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(children: [
        Expanded(
            child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            )),
          ),
        )),
        Expanded(
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Recipe Name
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.recipeName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                ),
              ),
              // Nutrition Score
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: RichText(
                          text: TextSpan(children: [
                        const WidgetSpan(
                            child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: Icon(
                            FontAwesome5.apple_alt,
                            size: 30,
                          ),
                        )),
                        TextSpan(
                            text: widget.nutritionScore,
                            style: Theme.of(context).textTheme.headline4),
                      ])),
                    ),
                  )),
              // Price
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RichText(
                              text: TextSpan(children: [
                            const WidgetSpan(
                                child: Icon(
                              FontAwesome5.dollar_sign,
                              size: 30,
                            )),
                            TextSpan(
                                text: widget.price,
                                style: Theme.of(context).textTheme.headline4)
                          ]))))),
              // Cook Time
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: RichText(
                            text: TextSpan(children: [
                          const WidgetSpan(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: Icon(
                              FontAwesome5.hourglass,
                              size: 30,
                            ),
                          )),
                          TextSpan(
                              text: widget.cookTime,
                              style: Theme.of(context).textTheme.headline4)
                        ])),
                      ))),
            ]),
          ),
        )
      ]),
    );
  }
}
