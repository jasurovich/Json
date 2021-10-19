import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:yangi/models/currency_model.dart';

import 'flag_list.dart';

class CurrencyApp extends StatefulWidget {
  @override
  _CurrencyAppState createState() => _CurrencyAppState();
}

class _CurrencyAppState extends State<CurrencyApp> {
  String dropdownValue = '\$ Tanlang';
  String dropdownValue2 = '\$ Tanlang';
  String dropdownValue3 = '\$ Tanlang';
  String miqdori = "";
  String miqdor2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      //App_Bar_Section________________//_______//
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "Valyuta Kursi",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      //Body_Bar_Section________________//_______//
      body: FutureBuilder(
        future: _getData(),
        builder: (context, AsyncSnapshot<List<Welcome>> snap) {
          var data = snap.data;
          return snap.hasData
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 150.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          //Drop_Down_1_Bar_Section________________//_______//
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.white,
                            ),
                            iconSize: 34,
                            style: const TextStyle(
                                backgroundColor: Colors.orange,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['\$ Tanlang', 'USD', 'UZS', 'RUB']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        //Exchange_Section________________//_______//
                        InkWell(
                          onTap: () {
                            setState(() {
                              dropdownValue = dropdownValue2;
                              dropdownValue2 = dropdownValue3;
                              dropdownValue3 = dropdownValue;
                            });
                          },
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(
                                50.0,
                              ),
                            ),
                            child: Icon(
                              Icons.change_circle_outlined,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        //Drop_Down_2_Bar_Section________________//_______//
                        Container(
                          alignment: Alignment.center,
                          width: 150.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: DropdownButton<String>(
                            value: dropdownValue2,
                            icon: const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.white,
                            ),
                            iconSize: 34,
                            style: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue2 = newValue!;
                              });
                            },
                            items: <String>['\$ Tanlang', 'USD', 'UZS', 'RUB']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    //Money_Amount_input_Section________________//_______//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 190.0,
                          child: TextField(
                            onChanged: (v) {
                              miqdori = v;
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey[700],
                              labelText: 'Pul Miqdori',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        //Result_Section________________//_______//
                        Container(
                          child: Text(
                            miqdor2,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                          alignment: Alignment.center,
                          width: 190.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ],
                    ),
                    //Result_Tap_Section________________//_______//
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (dropdownValue == "USD" &&
                              dropdownValue2 == "UZS") {
                            miqdor2 = (int.parse(miqdori) *
                                    double.parse(data![23].cbPrice)).toStringAsFixed(2)
                                .toString();
                          } else if(dropdownValue == "RUB" &&
                              dropdownValue2 == "UZS"){
                                miqdor2 = (int.parse(miqdori) *
                                    double.parse(data![18].cbPrice)).toStringAsFixed(2)
                                .toString();
                          }
                          else if(dropdownValue == "UZS" &&
                              dropdownValue2 == "RUB"){
                                miqdor2 = (int.parse(miqdori) /
                                    double.parse(data![18].cbPrice)).toStringAsFixed(2)
                                .toString();
                          }
                          else if(dropdownValue == "UZS" &&
                              dropdownValue2 == "USD"){
                                miqdor2 = (int.parse(miqdori) /
                                    double.parse(data![23].cbPrice)).toStringAsFixed(2)
                                .toString();
                          }
                          else if(dropdownValue == "RUB" &&
                              dropdownValue2 == "USD"){
                                miqdor2 = (int.parse(miqdori) *
                                    double.parse(data![23].cbPrice)).toStringAsFixed(2)
                                .toString();
                          }
                          else if(dropdownValue == "USD" &&
                              dropdownValue2 == "RUB"){
                                miqdor2 = (int.parse(miqdori) /
                                    double.parse(data![18].cbPrice)).toStringAsFixed(2)
                                .toString();
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 370.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        child: Text(
                          "Almashtirish",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                      ),
                    ),
                    //Main_Data_List_Section________________//_______//
                    Container(
                      height: 400.0,
                      width: 370.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: FutureBuilder(
                        future: _getData(),
                        builder: (context, AsyncSnapshot<List<Welcome>> snap) {
                          var data = snap.data;
                          return snap.hasData
                              ? ListView.builder(
                                  itemCount: data!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/images/" +
                                              Flag.Country_Names[index] +
                                              ".png",
                                        ),
                                      ),
                                      title: Text(
                                        data[index].title.toString(),
                                      ),
                                      subtitle: Text(
                                        data[index].date.toString(),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            data[index].code.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan[600],
                                            ),
                                          ),
                                          Text(
                                            data[index].cbPrice.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: CupertinoActivityIndicator(),
                                );
                        },
                      ),
                    )
                  ],
                )
              : Center(
                  child: CupertinoActivityIndicator(),
                );
        },
      ),
    );
  }

  Future<List<Welcome>> _getData() async {
    Uri url = Uri.parse("https://nbu.uz/uz/exchange-rates/json/");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => Welcome.fromJson(e))
          .toList();
    } else {
      throw Exception("Xato Bor : ${res.statusCode}");
    }
  }
}
