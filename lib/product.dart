import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recyclers/config/config.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Text(widget.entry.title, style: TextStyle(
              fontSize: 20
            ),),
          ),
          Stack(
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
                      child: CachedNetworkImage(
                      imageUrl: "http://${AppConfig.ip}/products/${widget.entry.user_id}/${widget.entry.image[i]}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                    ),
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
        ],
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
