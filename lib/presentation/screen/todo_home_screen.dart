import 'package:flutter/material.dart';
import 'package:todo_list_app/presentation/widget/calendear_body.dart';

class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    body: CalendearBody(),
    );
  }
}
