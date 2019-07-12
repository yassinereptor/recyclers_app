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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
            showDialog(context: context,builder: (context) => CardsDialog());
        },
        backgroundColor: Color(0xff00b661),
      ),
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
              Text("Add a Payment Method", style: TextStyle(
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

  class CardsDialog extends StatefulWidget {
      CardsDialog({Key key}) : super(key: key);
      @override
      State<StatefulWidget> createState() => CardsDialogState();
    }

class CardsDialogState extends State<CardsDialog>
        with SingleTickerProviderStateMixin{
AnimationController controller;
      Animation<double> scaleAnimation;
 @override
      void initState() {
        super.initState();
        
        controller =
            AnimationController(vsync: this, duration: Duration(milliseconds: 450));
        scaleAnimation =
            CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

        controller.addListener(() {
          setState(() {});
        });

        controller.forward();
      }


  @override
  Widget build(BuildContext context) {
    return Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Wrap(
                children: <Widget>[
                  Container(
                margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
                  decoration: ShapeDecoration(
                      color: Color(0xf100b661),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  child: Column(
                    children: <Widget>[
                     
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
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
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
                      color: Colors.white,
                      fontSize: 18
                    ),
                  )
                    ]
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.white,)                  
                ],
              ),
              )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
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
                      color: Colors.white,
                      fontSize: 18
                    ),
                  )
                    ]
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.white,)                  
                ],
              ),
              )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
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
                      color: Colors.white,
                      fontSize: 18
                    ),
                  )
                    ]
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.white,)                  
                ],
              ),
              )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
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
                      color: Colors.white,
                      fontSize: 18
                    ),
                  )
                    ]
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.white,)                  
                ],
              ),
              )
              ),
            ),
                    ],
                  )),
                ],
              )
            ),
          ),
        );
  }

}