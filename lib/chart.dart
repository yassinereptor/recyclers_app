import 'package:flutter/material.dart';


class ChartScreen extends StatefulWidget {
  var user;

  ChartScreen({Key key, this.user}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

@override
  void initState() {
    super.initState();

  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       body: Text("Chart"),
    );
  }
}
