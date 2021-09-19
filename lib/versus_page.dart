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
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/home_page_background.jpg"),
          fit: BoxFit.cover,
        )),
        child: Stack(children: [
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
                                  cookTime: model.jsonResponse[index]
                                      ["cookTime"]),
                            );
                          },
                          itemCount: model.jsonResponse.length ~/ 2,
                          itemWidth: MediaQuery.of(context).size.width,
                          itemHeight: MediaQuery.of(context).size.height * 0.5,
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
                                  recipeName: model.jsonResponse[
                                          model.jsonResponse.length - index - 1]
                                      ["recipeName"],
                                  nutritionScore:
                                      model.jsonResponse[model.jsonResponse.length - index - 1]
                                          ["nutritionScore"],
                                  price:
                                      model.jsonResponse[model.jsonResponse.length - index - 1]
                                          ["price"],
                                  image:
                                      model.jsonResponse[model.jsonResponse.length - index - 1]
                                          ["image"],
                                  cookTime:
                                      model.jsonResponse[model.jsonResponse.length - index - 1]
                                          ["cookTime"]),
                            );
                          },
                          itemCount: model.jsonResponse.length ~/ 2,
                          itemWidth: MediaQuery.of(context).size.width,
                          itemHeight: MediaQuery.of(context).size.height * 0.5,
                          layout: SwiperLayout.TINDER,
                        )),
              )
            ],
          ),
        ]));
  }
}
