import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localproject/Home%20.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('notepad');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
