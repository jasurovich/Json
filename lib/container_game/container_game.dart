import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ContainerGame extends StatefulWidget {
  @override
  _ContainerGameState createState() => _ContainerGameState();
}

class _ContainerGameState extends State<ContainerGame> {
  double boyi = 320;
  double Ikkinchiboyi = 320;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: Text(
            "Who is Faster 😁",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              color: Colors.purple,
              height: boyi,
              width: double.infinity,
            ),
            onTap: () {
              setState(() {
                if (boyi == 640) {
                  AwesomeDialog(
                    dismissOnTouchOutside: false,
                    context: context,
                    dialogType: DialogType.SUCCES,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Winner',
                    desc: "Purple One win",
                    btnOkOnPress: () {
                      setState(() {
                        boyi = 320;
                        Ikkinchiboyi = 320;
                      });
                    },
                  )..show();
                } else {
                  boyi += 20;
                  Ikkinchiboyi -= 20;
                }
              });
            },
          ),
          InkWell(
            child: Container(
              color: Colors.yellow,
              height: Ikkinchiboyi,
              width: double.infinity,
            ),
            onTap: () {
              setState(() {
                if (Ikkinchiboyi == 640) {
                  AwesomeDialog(
                    dismissOnTouchOutside: false,
                    context: context,
                    dialogType: DialogType.SUCCES,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Winner',
                    desc: "Yellow One win",
                    btnOkOnPress: () {
                      setState(() {
                        boyi = 320;
                        Ikkinchiboyi = 320;
                      });
                    },
                  )..show();
                } else {
                  boyi -= 20;
                  Ikkinchiboyi += 20;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
