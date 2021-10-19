import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _baho = 0;
  TextEditingController _fanController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  List<Widget> _results = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Baholarni Hisoblash",
          style: TextStyle(color: Colors.indigo),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              _dropDownWidgetim(),
              SizedBox(height: 20.0),
              _textFormFieldWidgetim(),
              SizedBox(height: 20.0),
              _buttonWidgetim(),
              SizedBox(height: 20.0),
              _baholarListim(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baholarListim(BuildContext ctx) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return _results[index];
        },
        itemCount: _results.length,
      ),
    );
  }

  Widget _dropDownWidgetim() {
    return Container(
      padding: EdgeInsets.only(left: 100.0, right: 100.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          itemHeight: 70.0,
          style: TextStyle(color: Colors.orange, fontSize: 22.0),
          value: _baho,
          items: [
            DropdownMenuItem(
              value: 100,
              child: Text(
                "100",
              ),
              onTap: () {
                setState(() {
                  _baho = 100;
                });
              },
            ),
            DropdownMenuItem(
              value: 80,
              child: Text("80"),
              onTap: () {
                setState(() {
                  _baho = 80;
                });
              },
            ),
            DropdownMenuItem(
              value: 60,
              child: Text("60"),
              onTap: () {
                setState(() {
                  _baho = 60;
                });
              },
            ),
            DropdownMenuItem(
              value: 0,
              child: Text("0"),
              onTap: () {
                setState(() {
                  _baho = 0;
                });
              },
            ),
          ],
          onChanged: (v) {
            setState(() {
              _baho = v!;
            });
          },
        ),
      ),
    );
  }

  Widget _textFormFieldWidgetim() {
    return TextFormField(
      key: _formKey,
      controller: _fanController,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.orange),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(),
        hintText: "Fan Nomini Kiriting....",
        labelText: "Fan Nomi",
      ),
      validator: (v) {
        if (v!.length < 3) {
          return "Belgilr Kam Kiritildi !!!";
        }
      },
    );
  }

  Widget _buttonWidgetim() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
        fixedSize: Size(120, 40),
      ),
      onPressed: () {
        setState(() {
          _results.add(
            ListTile(
              leading: CircleAvatar(
                child: Text("$_baho"),
              ),
              title: Text("${_fanController.text}"),
            ),
          );
        });
      },
      child: Text("Baho Qo'sh"),
    );
  }
}
