import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wouldyourather/home_page.dart';
import 'package:wouldyourather/preferences.dart';
import 'package:wouldyourather/Models/versus_model.dart';
import 'package:wouldyourather/versus_page.dart';
import 'package:wouldyourather/Models/preferences.dart';
import 'package:wouldyourather/Models/auth_model.dart';
import 'package:wouldyourather/recipe_page.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

// class MyAppStateless extends StatelessWidget {
//   const MyAppStateless({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MyApp();
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  FlutterAppAuth appAuth = FlutterAppAuth();
  String _clientId = '1ef4b7ee-7a72-4939-ba2d-d14c560c12a4';
  String _redirectUrl = 'com.example.wouldyourather://oauthredirect';
  String authorizationEndpoint =
      "https://foodwisehtn.b2clogin.com/te/foodwisehtn.onmicrosoft.com/B2C_1_signupsignin/oauth2/v2.0/authorize";
  String tokenEndpoint =
      "https://foodwisehtn.b2clogin.com/te/foodwisehtn.onmicrosoft.com/B2C_1_signupsignin/oauth2/v2.0/token";
  List<String> _scopes = ['openid', 'profile', 'email'];
  //"https://foodwisehtn.b2clogin.com/foodwisehtn.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_signupsignin";

  var _jwt;

  Future<void> _login() async {
    try {
      Map<String, String>? additionalParameters;
      bool preferEphemeralSession = false;
      if (Platform.isIOS) {
        additionalParameters = {
          'p': "B2C_1_signupsignin",
        };
        preferEphemeralSession = true;
      }

      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          additionalParameters: additionalParameters ?? null,
          preferEphemeralSession: preferEphemeralSession,
          serviceConfiguration: AuthorizationServiceConfiguration(
              authorizationEndpoint, tokenEndpoint),
          scopes: _scopes,
        ),
      );
      if (result != null) {
        _processAuthTokenResponse(result);
      }
    } catch (e) {
      stderr.writeln(e);
    }
  }

  _processAuthTokenResponse(AuthorizationTokenResponse result) {
    setState(() {
      _jwt = result.idToken;
    });
  }

  @override
  void initState() {
    _login(); // login right away.
    super.initState();
  }

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
        ),
        ChangeNotifierProvider<PreferencesModel>(
          create: (_) => PreferencesModel(),
        ),
        ChangeNotifierProvider<AuthModel>(
          create: (_) => AuthModel(),
        ),
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
          // "/": (BuildContext context) =>
          //     // ignore: prefer_const_constructors
          //     HomePage(title: 'Flutter Demo Home Page'),
          "/": (BuildContext context) {
            Provider.of<AuthModel>(context, listen: false).jwt = _jwt;

            return (_jwt == null)
                ? Scaffold(
                    body: Center(
                        child: Text("Please Login!",
                            style: TextStyle(fontSize: 30))),
                    floatingActionButton: FloatingActionButton.large(
                        onPressed: () {
                          _login();
                          Provider.of<AuthModel>(context, listen: false).jwt =
                              _jwt;
                        },
                        child: Icon(Icons.login)),
                  )
                : HomePage();
          },
          // ignore: prefer_const_constructors
          "/VersusPage": (BuildContext context) => VersusPage(),
          "/Preferences": (BuildContext context) => PreferencesPage(),
          "/RecipePage": (BuildContext context) => RecipePage(),
        },
      ),
    );
  }
}
