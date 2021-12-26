import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './pages/loading_page.dart';
import './utilities/constant.dart';
import './utilities/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox(Strings.settings);
  await Hive.openBox(Strings.statistics);

  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: "Poppins",
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: kBodyTextColor),
        ),
      ),
      home: const Scaffold(body: SafeArea(child: LoadingPage())),
    );
  }
}
