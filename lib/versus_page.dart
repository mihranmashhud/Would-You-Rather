import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wouldyourather/Models/versus_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wouldyourather/Components/single_card.dart';

class VersusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VersusPageState();
}

class _VersusPageState extends State<VersusPage> {
  List<String> images = [
    "https://www.click2houston.com/resizer/mAlhlQXB4CLlAmUQvp2osHvSqXY=/640x360/smart/filters:format(jpeg):strip_exif(true):strip_icc(true):no_upscale(true):quality(65)/arc-anglerfish-arc2-prod-gmg.s3.amazonaws.com/public/JRT5PXRT4VDR3P5MOKPQ5YZY5M.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Container(),
      Column(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                child: SingleCard(
                    recipeName: index.toString(),
                    nutritionScore: "14",
                    price: "4124",
                    image: images[0],
                    cookTime: "1234124"),
              );
            },
            itemCount: 10,
            itemWidth: 400.0,
            itemHeight: 400.0,
            layout: SwiperLayout.TINDER,
          )
        ],
      ),
    ]);
  }
}
