import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:recyclers/config/config.dart';
import 'package:recyclers/home.dart';
import 'package:recyclers/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recyclers/product.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoreScreen extends StatefulWidget {
  StoreScreen({Key key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

static String filter;
static List<int> fil_cat;

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
            child: IconButton(icon: Icon(icon, size: 22, color: (cats[i] == true)? Colors.white: Color(0xff054a29),), onPressed: (){
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
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text("Latest Offers", style: TextStyle(
                    fontFamily: "Oswald",
                    fontSize: 20,
                    color: Colors.black
                  ),),
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


    Widget _itemBuilder(context, ProductModel entry, _) {
      print("++++++++++++++++++++++++++++++++++++++++++++++++++");
      print("${entry.id}");
      print("++++++++++++++++++++++++++++++++++++++++++++++++++");
    return GestureDetector(
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
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context)=> PhotoHero(entry: entry,)
            ));
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
                      image: CachedNetworkImageProvider(
                        "http://${AppConfig.ip}/products/${entry.user_id}/${entry.image[0]}",
                        errorListener: (){
                          
                        }
                    )
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
                    Container(
                      padding: EdgeInsets.only(
                        right: 5,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 2),
                          child: Icon(Icons.timelapse, color: Color(0xff00b661), size: 18,),
                          ),
                          Text("${timeago.format(DateTime.parse(entry.time), locale: 'en_short')}", style: TextStyle(
                            color: Color(0xff00b661)
                          ),),
                          Text(" | ", style: TextStyle(fontSize: 20, color: Colors.grey[200]),),
                          Icon(Icons.star, color: Colors.yellow[800], size: 20,),
                          Text(entry.quality, style: TextStyle(color: Colors.yellow[800]),)
                        ],
                      ),
                    )
                  ],
                ),

                Container(
        padding: EdgeInsets.only(top: 0, bottom: 0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          child: Text("${entry.price} ", style: TextStyle(
                          color: Color(0xff00b661),
                          fontSize: 16
                        ),),
                        ),
                        Flexible(
                          child: Text("Dh / ${ProductUnit.getUnit(entry.unit)}", style: TextStyle(
                          color: Color(0xff00b661),
                        ),),
                        )
                      ],
                    ),
                    Text("In Stock: ${entry.quantity}", style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                    ),)
                  ],
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: FlatButton(
                    onPressed: (){},
                    color: Color(0xff00b661),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(entry.fix? "Add" : "Bid", style: TextStyle(
                      color: Colors.white,
                    fontSize: 12
                    ),
                    )),
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
    );
  }
}



class BackendService {
  
  static Future<List<ProductModel>> getProduct(fil_cat, filter, offset, limit) async {
    Dio dio = new Dio();
    final responseBody = (await dio.post("http://${AppConfig.ip}/api/product/load", data: {
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
  var image;


  ProductModel.fromJson(obj) {

      print("-------------------------------------------");
      print(obj);
      print("-------------------------------------------");
    this.id = obj["_id"];
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                    // The blue background emphasizes that it's a new route.
                    alignment: Alignment.center,
                    child: Hero(
                      tag: widget.entry.id,
                      child: CachedNetworkImage(
                      imageUrl: "http://${AppConfig.ip}/products/${widget.entry.user_id}/${widget.entry.image[0]}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                    )
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(widget.entry.title, style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),),
                  )
                    ],
                  ),
                  )
                );
  }
}