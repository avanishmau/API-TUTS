import 'dart:convert';

import 'package:api_tuts/models/PhotoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  List<PhotoModel> photos = [];

  Future<List<PhotoModel>> getPhotos() async {
    //final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    final response = await http.get(Uri.parse("http://jsonplaceholder.typicode.com/photos"));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        photos.add(PhotoModel.fromJson(i));
      }
      return photos;
    } else {
      return photos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Photos api test")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<PhotoModel>> snapshot) {
                return ListView.builder(
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                        ),
                        subtitle: Text(snapshot.data![index].id.toString()),
                        title: Text(snapshot.data![index].title.toString())
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
