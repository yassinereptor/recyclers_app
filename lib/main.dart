import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recyclers/home.dart';
import 'package:recyclers/welcome.dart';
import 'intro.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}

//#265463
//#407A61
//#ABBD8D
//#EBE2DD
//#F7F1F1

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recyclers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: new Color(0xff00b661)
      ),
      home: SplashScreen(),
      routes: {
        'home': (context) => SplashScreen() 
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('intro_seen') ?? false);

    var tmp = prefs.getString("user_data");
    var data = tmp != null? jsonDecode(tmp) : null;
    print('%%%%%%%%%%%||${data}||%%%%%%%%%%');

    if (_seen) {
      if(data != null)
      {
        Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new HomeScreen(data: data,)));
      }
      else
      {
        Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new WelcomeScreen()));
      }
    } else {
   prefs.setBool('intro_seen', true);
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 1500), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff00b661),
        child: Center(
          child: Container(
              alignment: Alignment.center,
              child: Padding(
                    child: Icon(IconData(0xe90a, fontFamily: "Iconmoon"), color: Colors.white, size: 150),
                    padding: EdgeInsets.only(right: 13),
                  ),
            ),
        )
      ),
    );
  }
}
