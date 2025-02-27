import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:recyclers/config/config.dart';
import 'package:recyclers/diposit.dart';
import 'package:recyclers/home.dart';
import 'package:recyclers/models/user.dart';
import 'package:recyclers/offers.dart';
import 'package:recyclers/payment.dart';
import 'package:recyclers/privacy_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  UserData user;
  Function callback;

  ProfileScreen({Key key, this.user, this.callback}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(this.user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserData user;

_ProfileScreenState(this.user);

@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("-----------------------------------");
    print(this.user.id);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff137547)
                ),
              ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
              ),
              )
            ],
          ),
          ScrollConfiguration(
            behavior: ScrollBehaviorCos(),
            child: ListView(
              padding: EdgeInsets.only(bottom: 50, top: 50),
            children: <Widget>[
              Column(
            children: <Widget>[
              Container(
              margin: EdgeInsets.only(top: 20, bottom: 15),
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                height: 150,
                child: InkWell(
                  onTap: (){
                    if((this.user != null && this.user.profile != "non"))
                    {                   
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context)=> PhotoProfileHero(link: "${AppConfig.ip}/profiles/" + this.user.id + ".png")
                      ));
                    }
                  },
                  child: Hero(
                    tag: "profile",
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 5, spreadRadius: 1),
                        ],
                        color: Colors.black,
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: (this.user == null || this.user.profile == "non")? AssetImage("assets/images/profile.png") : CachedNetworkImageProvider("${AppConfig.ip}/profiles/" + this.user.id + ".png")
                        )
                      ),
                    ),
                  )
                )
              ),
            ),
            Column(
                    children: <Widget>[
                      Text(
                        (this.user != null)? this.user.name : "",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        (this.user != null)? this.user.email : "",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                    children: <Widget>[
                      Text(
                        "Solde: ",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "00",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "In hold: ",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "00",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ),
              ],
            ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              decoration: BoxDecoration(
                boxShadow: [
                          BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 5, spreadRadius: 1),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: ()
                    {

                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.edit, color: Color(0xff00b661),),
                        ),
                        Text("Edit Profile", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context)=> OffersScreen()
                      ));
                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.store, color: Color(0xff00b661),),
                        ),
                        Text("My Offers", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {

                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.map, color: Color(0xff00b661),),
                        ),
                        Text("Shipping Address", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context)=> PaymentScreen(user: this.user,)
                      ));
                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.payment, color: Color(0xff00b661),),
                        ),
                        Text("Payment Method", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context)=> DipositScreen(user: this.user,)
                      ));
                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.monetization_on, color: Color(0xff00b661),),
                        ),
                        Text("Diposit", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {

                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.history, color: Color(0xff00b661),),
                        ),
                        Text("Order History", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      var obj = prefs.getString("user_data");
                      if(obj != null)
                      {
                          user.seller = !user.seller;
                          user.bayer = !user.bayer;

                          Map<String, dynamic> tmp = jsonDecode(obj);
                          new Dio().post("${AppConfig.ip}/api/profile/mode", data: {
                            "id": tmp['user']["_id"],
                            "seller": user.seller,
                            "bayer": user.bayer
                          }, options: Options(headers: {
                            "authorization": "Token ${tmp['user']['token']}",
                          })).then((val){
                            setState(() {
                              this.widget.callback();
                            });
                          });
                      }
                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                         Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.mode_edit, color: Color(0xff00b661),),
                        ),
                        Text("Mode", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(user.seller? "Seller" : "Bayer", style: TextStyle(color: Colors.grey),)
                    )
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {

                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                         Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.language, color: Color(0xff00b661),),
                        ),
                        Text("Language", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text("English", style: TextStyle(color: Colors.grey),)
                    )
                      ],
                    )
                  ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              decoration: BoxDecoration(
                boxShadow: [
                          BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 5, spreadRadius: 1),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: ()
                    {

                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.notifications_active, color: Color(0xff00b661),),
                        ),
                        Text("Notification Settings", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                      );
                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.note, color: Color(0xff00b661),),
                        ),
                        Text("Privacy Policy", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {

                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.question_answer, color: Color(0xff00b661),),
                        ),
                        Text("FAQ", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(color: Color(0xff00b661),),
                  ),
                  InkWell(
                    onTap: ()
                    {

                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.rate_review, color: Color(0xff00b661),),
                        ),
                        Text("Rate us", style: TextStyle(color: Color(0xff054A29)),),
                      ],
                    )
                  ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              decoration: BoxDecoration(
                boxShadow: [
                          BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 5, spreadRadius: 1),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: InkWell(
                    onTap: ()
                    {

                    },
                    child: Container(
                    decoration: BoxDecoration(
                      
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Icon(Icons.exit_to_app, color: Colors.red,),
                        ),
                        Text("Log out", style: TextStyle(color: Colors.red),),
                      ],
                    )
                  ),
                  ),
              )
            ],
          )
            ],
          ),
          )
        ],
      ),
    );
  }
}



class PhotoProfileHero extends StatefulWidget {

  String link;
PhotoProfileHero({@required this.link});

  @override
  _PhotoProfileHeroState createState() => _PhotoProfileHeroState();
}

class _PhotoProfileHeroState extends State<PhotoProfileHero> {

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
  //       print("()()()()()(()((()()()(");
  // print(widget.entry.image);
    }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
                  body: Container(
                    color: Colors.black,
                    child: Container(
                    // The blue background emphasizes that it's a new route.
                    alignment: Alignment.center,
                    child: Hero(
                      tag: "profile",
                      child: PhotoView(
                        imageProvider: CachedNetworkImageProvider(widget.link),
                      ),
                    )
                  ),
                  )
                );
  }
}