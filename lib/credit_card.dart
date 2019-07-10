import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recyclers/home.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

class CreditCardScreen extends StatefulWidget {

      String service;
      CreditCardScreen({Key key, this.service}) : super(key: key);
      @override
      State<StatefulWidget> createState() => CreditCardScreenState();
    }

    class CreditCardScreenState extends State<CreditCardScreen> with SingleTickerProviderStateMixin {
 

AnimationController _animationController;
  Animation<double> _curvedAnimation;

      @override
      void initState() {
        c_number_controller.addListener((){
          if(c_number_controller.text.length == 4 || c_number_controller.text.length  == 9 || c_number_controller.text.length == 14)
            c_number_controller.text += "-";
            
        });
        super.initState();
   
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
      }

      @override
  void dispose() {
    _animationController.dispose();
    c_number_controller.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }


      @override
      Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: (){},
            child: Text("Save", style: TextStyle(fontSize: 18),),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
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
         child: ListView(
         
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20, right: 20,bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text("Enter your informations of ${widget.service}", style: TextStyle(
                    fontFamily: "Oswald",
                    fontSize: 23,
                    color: Colors.black
                  ),),
            Row(
              children: <Widget>[
                Text("to continue ", style: TextStyle(
              fontFamily: "Oswald",
              fontSize: 15,
              color: Color(0xff00b661)
            ),),
           
              ],
            )
              ],
            ),
            ),
            
            Container(
              padding: EdgeInsets.all(10),
              child: FlipView(
                    animationController: _curvedAnimation,
                    front: _buildCard('A', () => _flip(true)),
                    back: _buildCard('B', () => _flip(false)),
                )
            )
          ],
        ),
       )
      ),
       
    );
      }

      TextEditingController c_number_controller = TextEditingController();


      Widget _buildCard(String title, GestureTapCallback onTap) {
    return AspectRatio(
      aspectRatio: 1.586,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            gradient: LinearGradient(
              colors: [
                Color(0xff00b661),
                Color(0Xff265463),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.1),
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    alignment: Alignment.centerRight,
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/mastercard_logo.png")
                      )
                    ),
                  ),
                  Form(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: new TextFormField(
                            style: TextStyle(
                              color: Colors.white
                            ),
                            controller: c_number_controller,
                                decoration: new InputDecoration(
                                  labelText: "Card Number",
                                  labelStyle: TextStyle(
                      ),
                                  fillColor: Colors.white,
                                ),
                                validator: (val) {
                                  if(val.length==0) {
                                    return "Title cannot be empty";
                                  }else{
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                        ),
                        ),
                      ],
                    ),
                    )
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
    }