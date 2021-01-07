import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

const platform = const MethodChannel(CHANNEL);
const CHANNEL = "id.acessodigital.native_communication.channel";
const KEY_NATIVE_LIVENESSX = "showNativeLivenessX";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo AcessoBio'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  String result = "";

  @override
  Widget build(BuildContext context) {

    Future<Null> _showNativeLiveness() async {
      result = await platform.invokeMethod(KEY_NATIVE_LIVENESSX);
      setState(() {
        result;
      });
    }

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Card(
              child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Image.memory(base64Decode(result)),
                  ),
                  new Container(
                    child: new Text('This is your result.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showNativeLiveness,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
}
