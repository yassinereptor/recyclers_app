import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:recyclers/config/config.dart';
import 'package:recyclers/credit_method.dart';
import 'package:recyclers/home.dart';
import 'package:recyclers/credit_card.dart';
import 'package:recyclers/privacy_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;


class DipositScreen extends StatefulWidget {
  var user;

  DipositScreen({Key key, this.user}) : super(key: key);

  @override
  _DipositScreenState createState() => _DipositScreenState();
}

class _DipositScreenState extends State<DipositScreen> {
  static var user;
  List<String> list = ["Helo", "cklds"];

@override
  void initState() {
    user = widget.user;

    _dropDownMenuItems = getDropDownMenuItems();
    dropdownValue = _dropDownMenuItems[0].value;
    super.initState();

  
  }

 List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String item in list) {
      items.add(new DropdownMenuItem(
          value: item,
          child: new Text(item)
      ));
    }
    return items;
  }

  // getItems()
  // async{
  //   Dio dio = new Dio();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var obj = prefs.getString("user_data");
  //   if(obj != null)
  //   {
  //     Map<String, dynamic> tmp = jsonDecode(obj);
  //     dio.post("${AppConfig.ip}/api/credit/load",
  //       options: Options(headers: {
  //         "authorization": "Token ${tmp['user']['token']}",
  //       }), data: {
  //       "id": tmp["user"]["_id"],
  //     }).then((data){
  //       print(data.data);
  //       setState(() {
                
  //             });
  //     });
  //   }
  // }

  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        //   FlatButton(
        //     textColor: Colors.white,
        //     onPressed: (){},
        //     child: Text("Save", style: TextStyle(fontSize: 18),),
        //     shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        //   ),
        // ],
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),
        tooltip: "Cancel and Return to List",
        onPressed: () {
          Navigator.pop(context, true);
        },
        )
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 30),
       child: ScrollConfiguration(
         behavior: ScrollBehaviorCos(),
         child: NestedScrollView(
         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
           return <Widget>[
           SliverToBoxAdapter(
             child: Container(
               child: Column(
                 children: <Widget>[
                   Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20, right: 20,bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text("Diposit to your Account", style: TextStyle(
                    fontFamily: "Oswald",
                    fontSize: 25,
                    color: Colors.black
                  ),),
            Row(
              children: <Widget>[
                Text("to continue ", style: TextStyle(
              fontFamily: "Oswald",
              fontSize: 15,
              color: Color(0xff00b661)
            ),),
                Container(
                child: Center(
                  child: InkWell(
                  onTap: (){
                      Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                          );
                  },
                  child: Text("( Privacy Policy )", style: TextStyle(
              fontFamily: "Oswald",
              decoration: TextDecoration.underline,
              fontSize: 15,
              color: Colors.red
            ),),
                ),
                )
              ),
              ],
            )
              ],
            ),
            ),
          
                 ],
               ),
             ),
           )
           ];
         },
         body: Container(
           padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Container(
            child:Row(
              children: <Widget>[
                Expanded(
                  child:  DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: _dropDownMenuItems
          ),
                )
              ],
            )
          )
            ],
          )
        )
        ),
       )
      ),
       
    );
  }

  
}
