import 'dart:convert';

import 'package:api_tuts/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApi () async {

    final response = await http.get(Uri.parse("http://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
        for(Map i in data){
         postList.add(PostModel.fromJson(i));
        }

        return postList;
    }else{
      return postList;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen")
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getPostApi(), builder: (
            context, snapshot){
              if(!snapshot.hasData){
                return Text("Loading....");
              }else{
                return ListView.builder(itemCount: postList.length,
                itemBuilder: (context, index){
                 return Text(postList[index].title.toString());
                });
              }
            }

            ),
          )
        ],
      ),
    );
  }
}
