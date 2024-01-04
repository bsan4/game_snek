import 'dart:math';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snake_snake/screen/gamescreen.dart';
import 'package:snake_snake/screen/splash_screen.dart';

import 'components/game.dart';
// import 'firebase_options.dart';
import 'providers/score_providers.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      textTheme: TextTheme(
        headline1: GoogleFonts.vt323(
          fontSize: 35,
          color: Colors.white,
        ),
        button: GoogleFonts.vt323(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: GoogleFonts.vt323(
          fontSize: 28,
          color: Colors.grey,
        ),
        bodyText2: GoogleFonts.vt323(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          minimumSize: const Size(150, 50),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hoverColor: Colors.red.shade700,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade700,
          ),
        ),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ScoreProvider()))
      ],
      child: MaterialApp(
        // routes: {
        //   GameScreen.routeName: (context) => GameScreen(),
        //   SplashScreen.routeName: (context) => SplashScreen(),
        // },

        onGenerateRoute: (RouteSettings routeSettings) {
          switch (routeSettings.name) {
            case GameScreen.routeName:
              return PageRouteBuilder(
                settings:
                    routeSettings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (_, __, ___) => GameScreen(),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              );
            case SplashScreen.routeName:
              return PageRouteBuilder(
                transitionDuration: Duration(seconds: 4),
                settings:
                    routeSettings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (_, __, ___) => SplashScreen(),
                transitionsBuilder: (_, a, __, c) {
                  return FadeTransition(opacity: a, child: c);
                },
              );

            //   );

            // case SplashScreen.routeName:
            //   return PageRouteBuilder(
            //     transitionDuration: const Duration(milliseconds: 1000),
            //     settings:
            //         routeSettings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
            //     pageBuilder: (_, __, ___) => const SplashScreen(),
            //     transitionsBuilder: (_, animation, __, ch) {
            //       const begin = Offset(
            //         1.0,
            //         0.0,
            //       );
            //       const end = Offset.zero;
            //       const curve = Curves.bounceOut;

            //       var tween = Tween(begin: begin, end: end)
            //           .chain(CurveTween(curve: curve));
            //       final offsetAnimation = animation.drive(tween);

            //       return SlideTransition(
            //         position: animation.drive(tween),
            //         child: ch,
            //       );
            //     },
            //   );
            default:
              return PageRouteBuilder(
                settings:
                    routeSettings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (_, __, ___) => GameScreen(),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              );
          }
        },
        title: 'PadRacing',
        home: SplashScreen(),
        theme: theme,
      ),
    );
  }
}
