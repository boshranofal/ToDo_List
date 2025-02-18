import 'package:flutter/material.dart';
import 'package:todo_list_app/presentation/screen/todo_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home:TodoHomeScreen(),
     
    );
  }
}
