import 'package:flutter/material.dart';
import 'package:flutter9_bttl_1/task_screen.dart';
import 'package:flutter9_bttl_1/task_detail.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const
        Color.fromARGB(255, 135, 200, 230)),
      ),
      debugShowCheckedModeBanner: false,
      home:TaskScreen(),
    );
  }
}