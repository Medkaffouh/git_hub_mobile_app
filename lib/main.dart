import 'package:flutter/material.dart';
import 'package:git_hub_mobile_app/pages/home/home.page.dart';
import 'package:git_hub_mobile_app/pages/users/users.page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      routes: {
        "/":(context)=>HomePage(),
        "/users":(context)=>UsersPage(),
      },
      initialRoute: "/users",
    );
  }
}

