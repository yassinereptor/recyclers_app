import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recyclers/config/config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recyclers/models/product.dart';

class ProductScreen extends StatefulWidget {

  var entry;
ProductScreen({@required this.entry});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<int> list;
  int _current = 0;

  @override
    void initState() {
      // list = new List(widget.entry.image.length);
      int i = 0;
      list = new List();
      while(i < widget.entry.image.length)
        list.add(i++);
      super.initState();
    }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.entry.title, style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 25,
        child: Container(
          height: 75,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Text("Price"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
        child: Column(
        children: <Widget>[
          Container(
            color: Color(0xff00b661),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            margin: EdgeInsets.only(bottom: 10),
            child: Stack(
            children: <Widget>[
              Container(
                child: CarouselSlider(
        initialPage: 0,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        items: list.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                ),
                child: Container(
                    // The blue background emphasizes that it's a new route.
                    alignment: Alignment.center,
                    child: Hero(
                      tag: widget.entry.id,
                      child: Container(
                        decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),                          
                          image: DecorationImage(
                            image: CachedNetworkImageProvider("http://${AppConfig.ip}/products/${widget.entry.user_id}/${widget.entry.image[i]}"),
                            fit: BoxFit.cover,
                          )
                        ),
                      )
                    )
                )
              );
            },
          );
        }).toList(),
      ),
              ),
      Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list.map((i) {
              return Container(
                width: _current == i? 16.0 : 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: _current == i ? Color.fromRGBO(255, 255, 255, 0.9) : Color.fromRGBO(255, 255, 255, 0.4)
                ),
              );
            }).toList(),
          )
        )
            ],
          )
          ),
         Container(
           padding: EdgeInsets.only(left: 20, right: 20),
           child: Column(
             children: <Widget>[
                Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Text("Details", style: TextStyle(
                    fontFamily: "Oswald",
                    fontSize: 20,
                    color: Colors.black
                  ),),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.yellow[800]),
                  Text("${widget.entry.quality}/5", style: TextStyle(color: Colors.yellow[800], fontSize: 18),)
                    ],
                  ),
            ],
          ),
    /////////////////
    
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),         
          child: DescriptionTextWidget(text: widget.entry.desc,),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Username:  ", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                  Text(widget.entry.user_name, style: TextStyle(
fontSize: 15
                  ),)
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: <Widget>[
                  Text("Quantity:  ", style: TextStyle(
                    fontWeight: FontWeight.bold,
fontSize: 15
                  ),),
                  Text(widget.entry.quantity.toString(), style: TextStyle(
                    fontSize: 15
                  ),)
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              
              Row(
                children: <Widget>[
                  Text("Category:  ", style: TextStyle(
                    fontWeight: FontWeight.bold,
fontSize: 15
                  ),),
                  Text(ProductCat.getCat(widget.entry.cat), style: TextStyle(
                    fontSize: 15
                  ),)
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),

            ],
          ),
        ),
        Divider()
             ],
           ),
         )
        ],
      ),
      ),
      )
      
                  // body: Container(
                  //   color: Colors.black,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //   // The blue background emphasizes that it's a new route.
                  //   alignment: Alignment.center,
                  //   child: Hero(
                  //     tag: widget.entry.id,
                  //     child: CachedNetworkImage(
                  //     imageUrl: "http://${AppConfig.ip}/products/${widget.entry.user_id}/${widget.entry.image[0]}",
                  //     fit: BoxFit.cover,
                  //     placeholder: (context, url) => new CircularProgressIndicator(),
                  //     errorWidget: (context, url, error) => new Icon(Icons.error),
                  // ),
                  //   )
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(top: 20),
                  //   child: Text(widget.entry.title, style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20
                  //   ),),
                  // )
                  //   ],
                  // ),
                  // )
                );
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
      padding: new EdgeInsets.symmetric(vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
                Container(

                  child: new InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(color: Color(0xff00b661)),
                      ),
                      ),
                       Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
                ),
                
              ],
            ),
    );
  }
}
