import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:git_hub_mobile_app/pages/repositories/home.page.dart';
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
  int currentPage=0;
  int totalPages=0;
  int pageSize=20;
  List<dynamic> items=[];
  ScrollController scrollController= ScrollController();

  void _search(String? query) {
    String url="https://api.github.com/search/users?q=$query&per_page=$pageSize&page=$currentPage";
    http.get(Uri.parse(url))
        .then((response) {
          setState((){
            data=json.decode(response.body);
            items.addAll(data['items']);
            if(data['total_count'] % pageSize ==0){
              totalPages=data['total_count']~/pageSize;
            }else{
              totalPages=(data['total_count']/pageSize).floor() +1;
            }

          });
          //JsonEncoder jsonEncoder= JsonEncoder.withIndent("   ");
          //print(jsonEncoder.convert(this.data));
    })
        .catchError((err){
          print(err);
    });
  }
  @override
  void initState(){
    //TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        setState((){
          if(currentPage<totalPages-1){
            ++currentPage;
            _search(query);
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    print("Building page ...");
    return Scaffold(
      appBar: AppBar(
        title: Text('Users => $query => $currentPage / $totalPages'),
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
                        items = [];
                        currentPage =0;
                        query = queryTextEditingController.text;
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
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 2,color: Colors.teal,),
                controller: scrollController,
                  itemCount: items.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GitRepositoriesPage(login: items[index]['login'],)));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(items[index]['avatar_url']),
                                radius: 30,
                              ),
                              const SizedBox(width: 20),
                              Text("${items[index]['login']}"),
                            ],
                          ),
                          CircleAvatar(
                            child: Text("${items[index]['score']}"),
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
