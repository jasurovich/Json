import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yangi/models/post_model.dart';
import 'package:http/http.dart' as http;

class MyApiJsonPage extends StatefulWidget {
  const MyApiJsonPage({ Key? key }) : super(key: key);

  @override
  _MyApiJsonPageState createState() => _MyApiJsonPageState();
}

class _MyApiJsonPageState extends State<MyApiJsonPage> {
  List<Post>? post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Api With Http",
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 26.0,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: _getData(),
          builder: (context, AsyncSnapshot<List<Post>> snap) {
            var data = snap.data;
            return snap.hasData ? ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  data[index].title.toString(),
                ),
                subtitle: Text(
                  data[index].userId.toString(),
                ),
              );
            },) : Center(child: CupertinoActivityIndicator(),);
          },
        ),
      ),
    );
  }
  Future<List<Post>> _getData() async{
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var res = await http.get(url);
    if (res.statusCode == 200){
      return(json.decode(res.body) as List).map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception("Xato Bor : ${res.statusCode}");
    }
  }
}