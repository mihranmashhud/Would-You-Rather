import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wouldyourather/main_page_user_input.dart';
import 'package:wouldyourather/home_page.dart';
import 'package:wouldyourather/preferences.dart';
import 'package:wouldyourather/Models/Versus_model.dart';
import 'package:wouldyourather/versus_page.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VersusModel>(
          create: (_) => VersusModel(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.oswaldTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (BuildContext context) =>
              // ignore: prefer_const_constructors
              HomePage(title: 'Flutter Demo Home Page'),
          "/VersusPage": (BuildContext context) => VersusPage(),
          "/Preferences": (BuildContext context) => PreferencesPage(),
        },
      ),
    );
  }
}
