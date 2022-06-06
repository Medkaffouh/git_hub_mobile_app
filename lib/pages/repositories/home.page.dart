import 'package:flutter/material.dart';

class GitRepositoriesPage extends StatelessWidget {
  String? login;
  GitRepositoriesPage({Key? key, this.login}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repositories $login'),),
      body:  Center(
        child: Text('Repositories $login'),
      ),
    );
  }
}