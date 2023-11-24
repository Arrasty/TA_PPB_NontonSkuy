import 'package:flutter/material.dart';
import 'package:nontonskuy/pages/get_started_page.dart';
import 'package:nontonskuy/pages/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nontonskuy/constant/style.dart';
import 'package:nontonskuy/model/hive_movie_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/splash_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(HiveMovieModelAdapter());
  //Hive.registerAdapter(HiveTVModelAdapter());
  await Hive.openBox<HiveMovieModel>('movie_lists');
  //await Hive.openBox<HiveTVModel>('tv_lists');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movie App',
      theme: ThemeData(
        scaffoldBackgroundColor: Style.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Style.primaryColor,
        ),
      ),
      routes: {
        '/':(context) => Splashpage(),
        '/get-started':(context) => GetStartedPage(),
        '/HomeScreen': (context) => HomeScreen(),
      },
    );
  }
}