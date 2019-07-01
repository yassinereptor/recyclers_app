import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:recyclers/config/config.dart';
import 'package:recyclers/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({Key key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

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
    super.initState();

  }

  static const int PAGE_SIZE = 10;

final _pageLoadController = PagewiseLoadController(
  pageSize: PAGE_SIZE,
  pageFuture: (pageIndex) =>
            BackendService.getProduct(pageIndex * PAGE_SIZE, PAGE_SIZE),
);

buildCat(IconData icon)
{
  return Container(
    alignment: Alignment.center,
            height: 40,
            width: 40,
            padding: EdgeInsets.only(bottom: 2, right: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
              ],
            ),
            child: IconButton(icon: Icon(icon, size: 22,), onPressed: (){}, alignment: Alignment.center,),
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
                      buildCat(IconData(0xe963, fontFamily: "Iconmoon")),
                      buildCat(IconData(0xe986, fontFamily: "Iconmoon")),
                      buildCat(IconData(0xe927, fontFamily: "Iconmoon")),
                      buildCat(IconData(0xe948, fontFamily: "Iconmoon")),
                      buildCat(IconData(0xe99e, fontFamily: "Iconmoon")),
                      buildCat(IconData(0xe963, fontFamily: "Iconmoon")),
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
        ),
      )
     
    );

  }


    Widget _itemBuilder(context, ProductModel entry, _) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      margin: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
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
              builder: (BuildContext context) {
                print("=------------${entry.id}-------------=");
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Flippers Page'),
                  ),
                  body: Container(
                    // The blue background emphasizes that it's a new route.
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.topLeft,
                    child: Hero(
                      tag: entry.id,
                      child: CachedNetworkImage(
                      imageUrl: "http://${AppConfig.ip}/products/${entry.user_id}/${entry.image}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                    )
                  ),
                );
              }
            ));
          },
           child:  Hero(
             tag: entry.id,
             child: Container(
          margin: EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          child: SizedBox(
            width: 120,
            height: 120,
            child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 2, spreadRadius: 0),
                    ],
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    // image: DecorationImage(
                    //   image:  AssetImage("assets/images/profile.png"),
                    //   fit: BoxFit.fill
                    // )
                  ),
                  child: CachedNetworkImage(
                      imageUrl: "http://${AppConfig.ip}/products/${entry.user_id}/${entry.image}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
            ),
          ),
           )
         ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 120,
                maxWidth: 200
              ),
              child: Container(
              padding: EdgeInsets.only(top: 5),
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
                        Text("by Username", style: TextStyle(
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
                          Icon(Icons.star, color: Colors.yellow[800],),
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
                          fontSize: 18
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
    );
  }
}




class BackendService {
  
  static Future<List<ProductModel>> getProduct(offset, limit) async {
    Dio dio = new Dio();
    final responseBody = (await dio.post("http://${AppConfig.ip}/api/product/load", data: {
            "filter": "",
            "skip": offset,
            "limit": limit
          }
    )).data;
   
    return ProductModel.fromJsonList(responseBody);
  }
}

class ProductModel {
  String id;
  String title;
  String user_id;
  String desc;
  String price;
  String quality;
  bool fix;
  bool bid;
  int quantity;
  int unit;
  String image;


  ProductModel.fromJson(obj) {

      print("-------------------------------------------");
      print(obj);
      print("-------------------------------------------");
    this.id = obj["id"];
    this.title = obj["title"];
    this.desc = obj["desc"];    
    this.user_id = obj["user_id"];
    this.price = obj["price"].toString();
    this.quality = obj["quality"].toString();
    this.quantity = obj["quantity"];
    this.unit = obj["unit"];
    this.image = obj["images"][0];
    this.fix = obj["fix"];
    this.bid = obj["bid"];

  }

  static List<ProductModel> fromJsonList(jsonList) {
    return jsonList.map<ProductModel>((obj) => ProductModel.fromJson(obj)).toList();
  }
}


class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}