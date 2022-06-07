import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GitRepositoriesPage extends StatefulWidget {
  String? login;
  GitRepositoriesPage({Key? key, this.login}) : super(key: key);

  @override
  State<GitRepositoriesPage> createState() => _GitRepositoriesPageState();
}

class _GitRepositoriesPageState extends State<GitRepositoriesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRepositories();
  }
  void loadRepositories(){
    String url = "https://api.github.com/users/mohamedYoussfi/repos";
    http.get(Uri.parse(url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repositories ${widget.login}'),),
      body:  Center(
        child: Text('Repositories ${widget.login}'),
      ),
    );
  }
}