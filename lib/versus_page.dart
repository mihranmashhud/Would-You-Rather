import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wouldyourather/Models/versus_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wouldyourather/Components/single_card.dart';
import 'package:wouldyourather/recipe_page.dart';

class VersusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VersusPageState();
}

class _VersusPageState extends State<VersusPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Container(),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/RecipePage");
            },
            child: Consumer<VersusModel>(
                builder: (context, model, child) => Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          child: SingleCard(
                              recipeName: model.jsonResponse[index]
                                  ["recipeName"],
                              nutritionScore: model.jsonResponse[index]
                                  ["nutritionScore"],
                              price: model.jsonResponse[index]["price"],
                              image: model.jsonResponse[index]["image"],
                              cookTime: model.jsonResponse[index]["cookTime"]),
                        );
                      },
                      itemCount: 2,
                      itemWidth: 400.0,
                      itemHeight: 270.0,
                      layout: SwiperLayout.TINDER,
                    )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/RecipePage");
            },
            child: Consumer<VersusModel>(
                builder: (context, model, child) => Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          child: SingleCard(
                              recipeName: model.jsonResponse[4 - index - 1]
                                  ["recipeName"],
                              nutritionScore: model.jsonResponse[4 - index - 1]
                                  ["nutritionScore"],
                              price: model.jsonResponse[4 - index - 1]["price"],
                              image: model.jsonResponse[4 - index - 1]["image"],
                              cookTime: model.jsonResponse[4 - index - 1]
                                  ["cookTime"]),
                        );
                      },
                      itemCount: 2,
                      itemWidth: 400.0,
                      itemHeight: 270.0,
                      layout: SwiperLayout.TINDER,
                    )),
          )
        ],
      ),
    ]);
  }
}
