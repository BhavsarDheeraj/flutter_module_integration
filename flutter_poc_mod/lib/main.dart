import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    platform.setMethodCallHandler(_receiveFromHost);
  }

  static const platform =
      const MethodChannel('com.dheerajbhavsar.flutter_poc/data');

  var data;

  Future<void> _receiveFromHost(MethodCall call) async {
    try {
      if (call.method == "fromHostToClient") {
        final String args = call.arguments;
        print(args);
        final dict = await jsonDecode(args);
        setState(() {
          data = dict;
        });
      }
    } on PlatformException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
          IconButton(
            onPressed: () => SystemNavigator.pop(animated: true),
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        // child: Text('The message from Native iOS/Android will appear here'),
        child: Text(data['message']),
      ),
    );
  }
}
