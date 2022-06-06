import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String? query;
  bool isSecure=false;
  TextEditingController queryTextEditingController = TextEditingController();

  dynamic data;

  void _search(String? query) {
    String url="https://api.github.com/search/users?q=${query}&per_page=20&page=0";
    http.get(Uri.parse(url))
        .then((response) {
          setState((){
            this.data=json.decode(response.body);
          });
          //JsonEncoder jsonEncoder= JsonEncoder.withIndent("   ");
          //print(jsonEncoder.convert(this.data));
    })
        .catchError((err){
          print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    print("Building page ...");
    return Scaffold(
      appBar: AppBar(
        title: Text('Users => ${query}'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: isSecure,
                        onChanged: (value){
                          setState((){
                            this.query=value;
                          });
                        },
                        controller: queryTextEditingController,
                        decoration: InputDecoration(
                            //icon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: isSecure==false?Icon(Icons.visibility):Icon(Icons.visibility_off),
                              onPressed: () {
                                setState((){
                                  isSecure=!isSecure;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.only(left: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.teal,
                                ))),
                      )),
                ),
                IconButton(
                    onPressed: () {
                      setState((){
                        this.query = queryTextEditingController.text;
                        _search(query);
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.teal,
                      size: 30,
                    ),
                    //padding: const EdgeInsets.only(right: 15),
                  ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: (data==null)?0:data['items'].length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(data['items'][index]['avatar_url']),
                                radius: 30,
                              ),
                              const SizedBox(width: 20),
                              Text("${data['items'][index]['login']}"),
                            ],
                          ),
                          CircleAvatar(
                            child: Text("${data['items'][index]['score']}"),
                          )
                        ],
                      )
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
