import 'package:flutter/material.dart';
import 'package:recyclers/home.dart';
import 'package:recyclers/credit_card.dart';
import 'package:recyclers/privacy_policy.dart';


class PaymentScreen extends StatefulWidget {
  var user;

  PaymentScreen({Key key, this.user}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

@override
  void initState() {
    super.initState();

  
  }

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
         child: ListView(
         
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20, right: 20,bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text("Select a Payment Method", style: TextStyle(
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
           
              ],
            )
              ],
            ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: InkWell(
                onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreditCardScreen(service: "MasterCard",)),
                      );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.white,
                boxShadow: [
                              BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
                            ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/credit-cards_mastercard.png")
                      )
                    ),
                  ),
                  Text(
                    "Mastercard",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ],
              ),
              )
              ),
            ),
Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.white,
                boxShadow: [
                              BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
                            ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/credit-cards_visa.png")
                      )
                    ),
                  ),
                  Text(
                    "Visa",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ],
              ),
              )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.white,
                boxShadow: [
                              BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
                            ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/credit-cards_paypal.png")
                      )
                    ),
                  ),
                  Text(
                    "Paypal",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ],
              ),
              )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Colors.white,
                boxShadow: [
                              BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
                            ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/credit-cards_bitcoin.png")
                      )
                    ),
                  ),
                  Text(
                    "Bitcoin",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ],
              ),
              )
              ),
            ),
            

          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: InkWell(
              onTap: (){
                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                      );
              },
              child: Text("Privacy Policy"),
            ),
            )
          )
          ],
        ),
       )
      ),
       
    );
  }
}
