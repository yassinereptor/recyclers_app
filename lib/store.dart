import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:photo_view/photo_view.dart';
import 'package:recyclers/config/config.dart';
import 'package:recyclers/home.dart';
import 'package:recyclers/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recyclers/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_slidable/flutter_slidable.dart';

class StoreScreen extends StatefulWidget {
  Function callback;

  StoreScreen({Key key, this.callback}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

static String filter;
static List<int> fil_cat;
var cart;
var bid;

Future getItems()
async {
  Dio dio = new Dio();
  cart.clear();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var obj = prefs.getString("user_data");
  if(obj != null)
  {
    Map<String, dynamic> tmp = jsonDecode(obj);
    dio.post("${AppConfig.ip}/api/cart/load",
      options: Options(headers: {
        "authorization": "Token ${tmp['user']['token']}",
      }), data: {
      "id": tmp["user"]["_id"]
    }).then((data){
      cart = data.data;


      dio.post("${AppConfig.ip}/api/bid/load",
      options: Options(headers: {
        "authorization": "Token ${tmp['user']['token']}",
        }), data: {
        "id": tmp["user"]["_id"]
      }).then((item){
        bid = item.data;
        setState(() {});
      });


      setState(() {});
    });
  }
}

Future removeItems(id)
      async {
        Dio dio = new Dio();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var obj = prefs.getString("user_data");
        if(obj != null)
        {
          Map<String, dynamic> tmp = jsonDecode(obj);
          dio.post("${AppConfig.ip}/api/cart/add",
            options: Options(headers: {
              "authorization": "Token ${tmp['user']['token']}",
            }), data: {
            "id": tmp["user"]["_id"],
            "prod_id": id,
          }).then((data){
          
            print(data.data);
            getItems();
            setState(() {
                    
                  });
          });
        }
      }
Future removeBid(id)
      async {
        Dio dio = new Dio();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var obj = prefs.getString("user_data");
        if(obj != null)
        {
          Map<String, dynamic> tmp = jsonDecode(obj);
          dio.post("${AppConfig.ip}/api/bid/add",
            options: Options(headers: {
              "authorization": "Token ${tmp['user']['token']}",
            }), data: {
            "id": tmp["user"]["_id"],
            "prod_id": id,
          }).then((data){
          
            print(data.data);
            getItems();
            setState(() {
                    
                  });
          });
        }
      }

@override
  void initState() {
    _pageLoadController.addListener(() {
    if (!_pageLoadController.hasMoreItems) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No More Items!')
        )
      );
    }
  });
  filter = "time";
  fil_cat = new List();
  cart = new List();
  bid = new List();
  getItems();
    super.initState();
  }

  static const int PAGE_SIZE = 10;

final _pageLoadController = PagewiseLoadController(
  pageSize: PAGE_SIZE,
  pageFuture: (pageIndex) =>
            BackendService.getProduct(fil_cat, filter, pageIndex * PAGE_SIZE, PAGE_SIZE),
);

List<bool> cats = [false, false, false, false, false, false];

buildCat(IconData icon, int i)
{
  return Container(
    alignment: Alignment.center,
            height: 40,
            width: 40,
            padding: EdgeInsets.only(bottom: 2, right: 3),
            decoration: BoxDecoration(
              color: (cats[i] == true)? Color(0xff00b661) : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
              ],
            ),
            child: IconButton(icon: Icon(icon, size: 22, color: (cats[i] == true)? Colors.white: Color(0xff054A29),), onPressed: (){
              setState(() {
                cats[i] = !cats[i];               
              });
              setState(() async{
                int j = 1;
                fil_cat.clear();
                cats.forEach((item){
                  if(item)
                    fil_cat.add(j);
                  j++;
                });
                this._pageLoadController.reset();
                getItems();
                await Future.value({});
              });
            }, alignment: Alignment.center,),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, inn){
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      left: 10
                    ),
                    child: Text("Categories", style: TextStyle(
                    fontFamily: "Oswald",
                    fontSize: 20,
                    color: Colors.black
                  ),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Wrap(
                    spacing: 15,
                    children: <Widget>[
                      buildCat(IconData(0xe963, fontFamily: "Iconmoon"), 0),
                      buildCat(IconData(0xe986, fontFamily: "Iconmoon"), 1),
                      buildCat(IconData(0xe927, fontFamily: "Iconmoon"), 2),
                      buildCat(IconData(0xe948, fontFamily: "Iconmoon"), 3),
                      buildCat(IconData(0xe99e, fontFamily: "Iconmoon"), 4),
                      buildCat(IconData(0xe928, fontFamily: "Iconmoon"), 5),
                    ],
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Latest Offers", style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 20,
                          color: Colors.black
                        ),),
                        OutlineButton(
                          highlightedBorderColor: Color(0xff00b661),
                          borderSide: BorderSide(
                            color: Color(0xff00b661)
                          ),
                          onPressed: (){
              
                          },
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("Filter", style: TextStyle(
                            color: Color(0xff00b661),
                          fontSize: 12
                          ),
                          )),
                        ),
                      ],
                    )
                  )
                ],
              )
            ),
            ),
          ];
        },
        body: Container(
          child: RefreshIndicator(
    onRefresh: () async {
      this._pageLoadController.reset();
      getItems();
      await Future.value({});
    },
    child: ScrollConfiguration(
      behavior: ScrollBehaviorCos(),
      child: PagewiseListView(
                        itemBuilder: this._itemBuilder,
                        pageLoadController: this._pageLoadController,
                        loadingBuilder: (context) {
                          return Text('Loading...');
                        },
                        noItemsFoundBuilder: (context) {
                          return Text('No Items Found');
                        },
                      ),
    )
  )
        ),
      )
     
    );

  }

checkCart(id)
{
  bool flag = false;

  if(cart.length > 0)
  {

    cart.forEach((it){

      if(it["_id"] == id)
      {
          flag = true;
      }
    });
  }

  if(bid.length > 0)
  {

    bid.forEach((it){

      if(it["_id"] == id)
      {
          flag = true;
      }
    });
  }

  return (flag);
}

    Widget _itemBuilder(context, ProductModel entry, _) {
     
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        Container(
          child: Container(
                      padding: EdgeInsets.only(
                        right: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                child: Icon(Icons.timelapse, color: Color(0xff00b661), size: 18,),
                                ),
                                Text("${timeago.format(DateTime.parse(entry.time), locale: 'en_short')}", style: TextStyle(
                                  color: Color(0xff00b661), fontSize: 15
                                ),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.star, color: Colors.yellow[800], size: 20,),
                                ),
                                Text("${entry.quality}/5", style: TextStyle(color: Colors.yellow[800], fontSize: 15),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      ],
      child: GestureDetector(
      onTap: (){
         Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context)=> ProductScreen(entry: entry,)
            ));
      },
      child: Container(
      padding: EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
      margin: EdgeInsets.only(left: 5, right: 5, top: 6, bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        color: Colors.white,
        boxShadow: [
                      BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
                    ],
      ),
      child: 
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         GestureDetector(
          onTap: (){
            if((entry.image.length != 0))
            {
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context)=> PhotoHero(entry: entry,)
              ));
            }
          },
           child:  Hero(
             tag: entry.id,
             child: Container(
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),

               ),
          margin: EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          child: SizedBox(
            width: 130,
            height: 110,
            child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3), topLeft: Radius.circular(3)),
                    // boxShadow: [
                    //   BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
                    // ],
                    color: Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                      image: (entry.image.length != 0)? CachedNetworkImageProvider(
                        "${AppConfig.ip}/products/${entry.user_id}/${entry.image[0]}",
                        errorListener: (){
                          
                        }
                    ) : AssetImage("assets/images/placeholder.png")
                    )

                    // image: DecorationImage(
                    //   image:  AssetImage("assets/images/profile.png"),
                    //   fit: BoxFit.fill
                    // )
                  ),
                ),
            ),
          ),
           )
         ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 110,
                maxWidth: 200
              ),
              child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(entry.title, style: TextStyle(
                          fontSize: 18
                        ),),
                        Text("by ${entry.user_name}", style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                        ),),
                          ],
                        )
                   
                      )
                    ),
                    Icon(Icons.keyboard_return, color: Colors.grey[200], size: 15)
                  ],
                ),

                Container(
        padding: EdgeInsets.only(top: 0, bottom: 0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: entry.fix? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          child: Text("${double.parse(entry.price)} ", style: TextStyle(
                          color: Color(0xff00b661),
                          fontSize: 16
                        ),),
                        ),
                        Flexible(
                          child: Text("Dh / ${ProductUnit.getUnit(entry.unit)}", style: TextStyle(
                          color: Color(0xff00b661),
                          fontSize: 12,
                        ),),
                        )
                      ],
                    ),
                    Text("In Stock: ${entry.quantity}", style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                    ),)
                  ],
                ) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.timer, size: 15, color: Colors.grey,),      
                        ),
                      Text("∞", style: TextStyle(
                        color: Color(0xff00b661)
                      ),),
                      Container(
                        padding: EdgeInsets.only(left: 2, right: 2),
                        child: Text("|", style: TextStyle(
                        color: Colors.grey
                      ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.person_outline, size: 16, color: Colors.grey,),      
                        ),
                      Text("6 bid", style: TextStyle(
                        color: Color(0xff00b661)
                      ),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.shopping_basket, size: 15, color: Colors.grey,),      
                        ),
                  Text("${entry.quantity} ${ProductUnit.getUnit(entry.unit)}", style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                    ),)
                    ],
                  )
                  ],
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: FlatButton(
                    onPressed: (){
                      if(entry.fix)
                      {
                        if(checkCart(entry.id))
                          removeItems(entry.id);
                        else
                          showDialog(context: context,builder: (context) => QuanOverlay(entry: entry, getItems: getItems));
                      }
                      else
                      {
                        if(checkCart(entry.id))
                        {
                          removeBid(entry.id);
                        }
                        else
                          showDialog(context: context,builder: (context) => BidOverlay(entry: entry, getItems: getItems));
                      }
                    },
                    color: Color(0xff00b661),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: (!checkCart(entry.id))? Container(
                      alignment: Alignment.center,
                      child: Text(entry.fix? "Add" : "Bid", style: TextStyle(
                      color: Colors.white,
                    fontSize: 12
                    ),
                    )): Container(
                      child: Icon(Icons.check, color: Colors.white,),
                    ),
                  ),
              ),
            )
          ],
        ),
      )
              ],
            ),
          ),
            )
          )
        ],
      )
    ),
    ),
    );
  }
}



class BackendService {
  
  static Future<List<ProductModel>> getProduct(fil_cat, filter, offset, limit) async {
    Dio dio = new Dio();
    final responseBody = (await dio.post("${AppConfig.ip}/api/product/load", data: {
            "cats": fil_cat,
            "filter": filter,
            "skip": offset,
            "limit": limit
          }
    )).data;
   
    print(responseBody);
    return ProductModel.fromJsonList(responseBody);
  }
}

class ProductModel {
  String id;
  String title;
  String user_id;
  String user_name;
  String desc;
  String price;
  String quality;
  String time;
  bool fix;
  bool bid;
  int quantity;
  int unit;
  int cat;
  int order;
  var image;
  var bid_list;


  ProductModel.fromJson(obj) {

    this.id = obj["_id"];
    this.order = obj["order"];
    this.bid_list = obj["bid_list"];
    this.title = obj["title"];
    this.desc = obj["desc"];    
    this.user_id = obj["user_id"];
    this.user_name = obj["user_name"];
    this.price = obj["price"].toString();
    this.quality = obj["quality"].toString();
    this.quantity = obj["quantity"];
    this.unit = obj["unit"];
    this.image = obj["images"];
    this.fix = obj["fix"];
    this.bid = obj["bid"];
    this.time = obj["time"];
    this.cat = obj["cat"];

  }

  static List<ProductModel> fromJsonList(jsonList) {
    return jsonList.map<ProductModel>((obj) => ProductModel.fromJson(obj)).toList();
  }
}



class PhotoHero extends StatefulWidget {

  var entry;
PhotoHero({@required this.entry});

  @override
  _PhotoHeroState createState() => _PhotoHeroState();
}

class _PhotoHeroState extends State<PhotoHero> {

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
                      tag: widget.entry.id,
                      child: PhotoView(
                        imageProvider: CachedNetworkImageProvider("${AppConfig.ip}/products/${widget.entry.user_id}/${widget.entry.image[0]}"),
                      ),
                    )
                  ),
                  )
                );
  }
}




class QuanOverlay extends StatefulWidget {
      var entry;
      Function getItems;


      QuanOverlay({Key key, this.entry, this.getItems}) : super(key: key);
      @override
      State<StatefulWidget> createState() => QuanOverlayState();
    }

    class QuanOverlayState extends State<QuanOverlay>
        with SingleTickerProviderStateMixin {
      AnimationController controller;
      Animation<double> scaleAnimation;
      var dropdownValue;

      TextEditingController qua_controller = TextEditingController();


      Future addItems()
      async {
        Dio dio = new Dio();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var obj = prefs.getString("user_data");
        if(obj != null)
        {
          Map<String, dynamic> tmp = jsonDecode(obj);
          dio.post("${AppConfig.ip}/api/cart/add",
            options: Options(headers: {
              "authorization": "Token ${tmp['user']['token']}",
            }), data: {
            "id": tmp["user"]["_id"],
            "prod_id": widget.entry.id,
            "quantite": int.parse(qua_controller.text)
          }).then((data){
          
            print(data.data);
            this.widget.getItems();
            setState(() {
                    
                  });
          });
        }
        Navigator.pop(context);
      }

      @override
      void initState() {
        qua_controller.text = 1.toString();
        dropdownValue = 1.toString();
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
              child: Container(
                margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(5.0),
                  height: 210.0,
                  decoration: ShapeDecoration(
                      color: Color(0xf100b661),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20.0, right: 20.0),
                        child: Text(
                          "Choose a quantity",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: new TextFormField(
                            style: TextStyle(
                              color: Colors.white
                            ),
                            controller: qua_controller,
                                decoration: new InputDecoration(
                                  suffixText: "Max ${widget.entry.quantity} ${ProductUnit.getUnit(widget.entry.unit)}",
                                  suffixStyle: TextStyle(
                                  color: Colors.white
                                ),
                                  labelText: "Quantity",
                                  labelStyle: TextStyle(
                                  color: Colors.white
                                ),
                                  fillColor: Colors.white,
                                  //fillColor: Colors.green
                                ),
                                cursorColor: Colors.white,
                                validator: (val){
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                        ),
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FlatButton(
                                onPressed: (){
                                  
                                 addItems();
                                },
                                color: Colors.white,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Add", style: TextStyle(
                                  color: Color(0xf100b661),
                                fontSize: 12
                                ),
                                ))
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 16.0, top: 16.0, bottom: 16.0),
                            child:  FlatButton(
                                onPressed: (){
                                 Navigator.pop(context);
                                },
                                color: Colors.white,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Cancel", style: TextStyle(
                                  color: Color(0xf100b661),
                                fontSize: 12
                                ),
                                ))
                              ),
                          ),
                        ],
                      ))
                    ],
                  )),
            ),
          ),
        );
      }
    }



  class BidOverlay extends StatefulWidget {
      var entry;
      Function getItems;


      BidOverlay({Key key, this.entry, this.getItems}) : super(key: key);
      @override
      State<StatefulWidget> createState() => BidOverlayState();
    }

    class BidOverlayState extends State<BidOverlay>
        with SingleTickerProviderStateMixin {
      AnimationController controller;
      Animation<double> scaleAnimation;
      var dropdownValue;

      TextEditingController qua_controller = TextEditingController();


      Future addItems()
      async {
        Dio dio = new Dio();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var obj = prefs.getString("user_data");
        if(obj != null)
        {
          Map<String, dynamic> tmp = jsonDecode(obj);
          dio.post("${AppConfig.ip}/api/bid/add",
            options: Options(headers: {
              "authorization": "Token ${tmp['user']['token']}",
            }), data: {
            "id": tmp["user"]["_id"],
            "prod_id": widget.entry.id,
            "bid": double.parse(qua_controller.text)
          }).then((data){
          
            print(data.data);
            this.widget.getItems();
            setState(() {
                    
                  });
          });
        }
        Navigator.pop(context);
      }

      @override
      void initState() {
        qua_controller.text = 1.toString();
        dropdownValue = 1.toString();
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
              child: Container(
                margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(5.0),
                  height: 210.0,
                  decoration: ShapeDecoration(
                      color: Color(0xf100b661),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20.0, right: 20.0),
                        child: Text(
                          "Add a Bid",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: new TextFormField(
                            style: TextStyle(
                              color: Colors.white
                            ),
                            controller: qua_controller,
                                decoration: new InputDecoration(
                                //   suffixText: "Max ${widget.entry.quantity} ${ProductUnit.getUnit(widget.entry.unit)}",
                                //   suffixStyle: TextStyle(
                                //   color: Colors.white
                                // ),
                                  labelText: "Enter a bidding price",
                                  labelStyle: TextStyle(
                                  color: Colors.white
                                ),
                                  fillColor: Colors.white,
                                  //fillColor: Colors.green
                                ),
                                cursorColor: Colors.white,
                                validator: (val){
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                        ),
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FlatButton(
                                onPressed: (){
                                  
                                 addItems();
                                },
                                color: Colors.white,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Bid", style: TextStyle(
                                  color: Color(0xf100b661),
                                fontSize: 12
                                ),
                                ))
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 16.0, top: 16.0, bottom: 16.0),
                            child:  FlatButton(
                                onPressed: (){
                                 Navigator.pop(context);
                                },
                                color: Colors.white,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Cancel", style: TextStyle(
                                  color: Color(0xf100b661),
                                fontSize: 12
                                ),
                                ))
                              ),
                          ),
                        ],
                      ))
                    ],
                  )),
            ),
          ),
        );
      }
    }