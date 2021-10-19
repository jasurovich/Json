import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yangi/models/cars_model.dart';

class MyLocalJsonPageState extends StatefulWidget {
  @override
  _MyLocalJsonPageStateState createState() => _MyLocalJsonPageStateState();
}

class _MyLocalJsonPageStateState extends State<MyLocalJsonPageState> {
  var data;
  @override
  Widget build(BuildContext context) {
    malumotlarniOlibKelBratish().then((value) async {
      data = value;
      await Future.delayed(Duration(seconds: 1), () {});
      setState(() {});
    });
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Work with Json in Dart",
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 400.0,
              child: FutureBuilder(
                future: malumotlarniOlibKelBratish(),
                builder: (context, AsyncSnapshot <List<Car>> snap) {
                  return snap.hasData
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "Name: ${data![index]!.car_name}"),
                              subtitle: Text(
                                  "Yili: ${data[index]!.year}"),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    data[index]!.photo.toString() + index.toString()),
                              ),
                            );
                          },
                          itemCount: snap.data!.length,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {});
                await Future.delayed(Duration(seconds: 2), () {});
                setState(() {});
              },
              child: Text("Click me!"),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Car>> malumotlarniOlibKelBratish() async {
    var kelganJson = await DefaultAssetBundle.of(context)
        .loadString("assets/data/data.json");

    List<Car> listOfCar =
        (json.decode(kelganJson) as List).map((e) => Car.fromJson(e)).toList();
    return listOfCar;
  }
}


