import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/presentation/screen/todo_home_screen.dart';
import 'package:todo_list_app/provider/task_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    )
  );
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
