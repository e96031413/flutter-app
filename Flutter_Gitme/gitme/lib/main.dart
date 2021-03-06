import "package:flutter/material.dart";
import "package:gitme/pages/login.dart";
import 'package:gitme/pages/home.dart';
import 'package:gitme/routes.dart';


void main() => runApp(GitmeRebornApp());

class GitmeRebornApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gitme Reborn",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
 routes: {
        GitmeRebornRoutes.login: (context) => LoginPage(),
        GitmeRebornRoutes.home: (context) => MainPage(),   
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case GitmeRebornRoutes.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}