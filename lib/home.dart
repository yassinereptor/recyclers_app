 import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:recyclers/add_bayer.dart';
import 'package:recyclers/add_seller.dart';
import 'package:recyclers/cart.dart';
import 'package:recyclers/config/config.dart';
import 'package:recyclers/models/user.dart';
import 'package:recyclers/notification.dart';
import 'package:recyclers/profile.dart';
import 'package:recyclers/store.dart';
import 'package:dio/dio.dart';
import 'package:recyclers/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  var data;
  HomeScreen({Key key, @required  this.data}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(this.data);
}

class _HomeScreenState extends State<HomeScreen> {


@override
  void initState() {
    super.initState();
    getDataState();      
  }

  var data;
  UserData user;

  Future getDataState() async
  {
      this.user = await getData();   
      setState(() {
        
      });
  }

  Future getData()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var obj = prefs.getString("user_data");
    if(obj != null)
    {
      Map<String, dynamic> tmp = jsonDecode(obj);
      Response response;
      Dio dio = new Dio();
      response = await dio.get("http://${AppConfig.ip}/api/current?id=${tmp['user']['_id']}",
      options: Options(headers: {
        "authorization": "Token ${tmp['user']['token']}",
      }));
      if(response.statusCode == 200)
      {
        UserData user;
        user = new UserData();
        user.email = response.data["user"]["email"];
        user.name = response.data["user"]["name"];
        user.company_name = response.data["user"]["company_name"];
        user.company_id = response.data["user"]["company_id"];
        user.cin = response.data["user"]["cin"];
        user.phone = response.data["user"]["phone"];
        user.country = response.data["user"]["country"];
        user.pos = response.data["user"]["pos"];
        user.seller = response.data["user"]["seller"];
        user.bayer = response.data["user"]["bayer"];
        user.latLng = new LatLng(double.parse(response.data["user"]["lat"]), double.parse(response.data["user"]["lng"]));
        user.profile = response.data["user"]["profile"];

        print("------------------------------------------------------------------");
        print(user.email);
        print(user.name);
        print(user.company_name);
        print(user.company_id);
        print(user.cin);
        print(user.phone);
        print(user.country);
        print(user.pos);
        print(user.seller);
        print(user.bayer);
        print(user.latLng);
        print(user.profile);
        print("------------------------------------------------------------------");

        return user;
      }
    }
    return null;
  }


  _HomeScreenState(this.data);



  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  

  Widget headerView(BuildContext context) { 
     Uint8List bytes;
    if(this.user != null)
    {
      bytes = base64.decode(this.user.profile);
    } 
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: <Widget>[
              new Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: (this.user == null || this.user.profile == "non")? AssetImage("assets/images/profile.png") : MemoryImage(bytes)
                        )
                      )
                    ),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  ))
            ],
          ),
        ),
        Divider(
          color: Colors.white.withAlpha(200),
          height: 16,
        )
      ],
    );
  }


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  List<String> menuItems = [
    "Home",
    "Settings",
    "Log out"
  ];

  List<IconData> menuItemsIcons = [
    Icons.home,
    Icons.settings,
    Icons.exit_to_app
  ];

  getMenu()
  {
    List<Widget> list = new List();
    int pos = 0;
  list.add(
        Divider(color: Colors.white54)
      );
    menuItems.forEach((i){
      list.add(
        FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                    onPressed: (){
                      SimpleHiddenDrawerProvider.of(context)
                      .setSelectedMenuPosition(pos);
                    },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: Row(
                      children: <Widget>[
                        Icon(menuItemsIcons[pos], color: Colors.white,),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                      width: 100,
                      child: Text(i, style: TextStyle(
                      color: Colors.white,
                    fontSize: 18
                    ),
                    ))
                      ],
                    ),
                  )
      );
      list.add(
        Divider(color: Colors.white54)
      );
      pos++;
    });

    return (list);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
        menu: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Color(0xff00b661),
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: headerView(context),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: getMenu(),
                      ),
                    )
                  ],
                )
              ),
        screenSelectedBuilder: (position,controller) {
          
          Widget screenCurrent;
          
          switch(position){
            case 0 : break;
            case 1 : break;
            case 2 : break;
          }
          
          return HomeInsiderScreen();
        }
    );
  }

}


class ScrollBehaviorCos extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}




class HomeInsiderScreen extends StatefulWidget {
  UserData data;
  HomeInsiderScreen({Key key}) : super(key: key);

  @override
  _HomeInsiderScreenState createState() => _HomeInsiderScreenState();
}

class _HomeInsiderScreenState extends State<HomeInsiderScreen> {

  UserData user;

  @override
  void initState() {
    super.initState();
    hideBar = 0; 
    currentIndex = 0;
    getDataState();
    items =  [
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.dashboard, color: Color(0xff054a29),), activeIcon: Icon(Icons.dashboard, color: Color(0xff00b661),), title: Text("Store")),
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.shopping_cart, color: Color(0xff054a29),), activeIcon: Icon(Icons.shopping_cart, color: Color(0xff00b661),), title: Text("Cart")),
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.notifications, color: Color(0xff054a29),), activeIcon: Icon(Icons.notifications, color: Color(0xff00b661),), title: Text("News")),
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.person, color: Color(0xff054a29),), activeIcon: Icon(Icons.person, color: Color(0xff00b661),), title: Text("Profile"))
              ];

  }
    Future getDataState() async
  {
      this.user = await getData();   
      setState(() {
         items = (this.user == null)?
              [
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.dashboard, color: Color(0xff054a29),), activeIcon: Icon(Icons.dashboard, color: Color(0xff00b661),), title: Text("Store")),
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.shopping_cart, color: Color(0xff054a29),), activeIcon: Icon(Icons.shopping_cart, color: Color(0xff00b661),), title: Text("Cart")),
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.notifications, color: Color(0xff054a29),), activeIcon: Icon(Icons.notifications, color: Color(0xff00b661),), title: Text("News")),
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.person, color: Color(0xff054a29),), activeIcon: Icon(Icons.person, color: Color(0xff00b661),), title: Text("Profile"))
              ]:
              [
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.dashboard, color: Color(0xff054a29),), activeIcon: Icon(Icons.dashboard, color: Color(0xff00b661),), title: Text("Store")),
                  (this.user.seller == true && this.user.bayer == false)?
                    BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.bubble_chart, color: Color(0xff054a29),), activeIcon: Icon(Icons.bubble_chart, color: Color(0xff00b661),), title: Text("Chart"))
                  :  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.shopping_cart, color: Color(0xff054a29),), activeIcon: Icon(Icons.shopping_cart, color: Color(0xff00b661),), title: Text("Cart")),
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.notifications, color: Color(0xff054a29),), activeIcon: Icon(Icons.notifications, color: Color(0xff00b661),), title: Text("News")),
                  BubbleBottomBarItem(backgroundColor: Color(0xff00b661), icon: Icon(Icons.person, color: Color(0xff054a29),), activeIcon: Icon(Icons.person, color: Color(0xff00b661),), title: Text("Profile"))
              ];
      });
  }

  Future getData()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var obj = prefs.getString("user_data");
    if(obj != null)
    {
      Map<String, dynamic> tmp = jsonDecode(obj);
      Response response;
      Dio dio = new Dio();
      response = await dio.get("http://${AppConfig.ip}/api/current?id=${tmp['user']['_id']}",
      options: Options(headers: {
        "authorization": "Token ${tmp['user']['token']}",
      }));
      if(response.statusCode == 200)
      {
        UserData user;
        user = new UserData();
        user.email = response.data["user"]["email"];
        user.name = response.data["user"]["name"];
        user.company_name = response.data["user"]["company_name"];
        user.company_id = response.data["user"]["company_id"];
        user.cin = response.data["user"]["cin"];
        user.phone = response.data["user"]["phone"];
        user.country = response.data["user"]["country"];
        user.pos = response.data["user"]["pos"];
        user.seller = response.data["user"]["seller"];
        user.bayer = response.data["user"]["bayer"];
        user.latLng = new LatLng(double.parse(response.data["user"]["lat"]), double.parse(response.data["user"]["lng"]));
        user.profile = response.data["user"]["profile"];
        return user;
      }
    }
    return null;
  }
  

  _HomeInsiderScreenState();

  int currentIndex;
  int hideBar;
  
  changePage(i)
  {
    setState(() {
      if(i == 3)
        hideBar = 1;
      else
        hideBar = 0;
      currentIndex = i;
    });
  }

  onSearchPress()
  {

  }

  onAddPress()
  {
    if(this.user.seller == true && this.user.bayer == false)
    {
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSellerScreen(data: this.user,)),
          );
    }
    else
    {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBayerScreen()),
          );
    }
  }

  getScreen()
  {
    switch(currentIndex)
    {
      case 0:
        return StoreScreen();
        break;
      case 1:
        if(this.user == null)
          Navigator.pop(context);
        return CartScreen();
        break;
      case 2:
        if(this.user == null)
         Navigator.pop(context);
        return NotificationScreen();
        break;
      case 3:
        if(this.user == null)
          Navigator.pop(context);
         return ProfileScreen(user: this.user,);
        break;
    }

  }

  var items;
  
  @override
  Widget build(BuildContext context) {
    if (this.user == null)
    {
      return Scaffold(
        bottomNavigationBar: BubbleBottomBar(
                opacity: .2,
                currentIndex: currentIndex,
                onTap: changePage,
                borderRadius: BorderRadius.zero,
                elevation: 12,
                hasNotch: false,
                hasInk: true,
                inkColor: Colors.black12,
                items: items
                
              ),
          appBar: AppBar(
              leading: Container(),
                  bottom: PreferredSize(child: Container(), preferredSize: Size.fromHeight(30)),
                  flexibleSpace: FlexibleSpaceBar.createSettings(
                    currentExtent: 20,
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                      child: Container(
                              child: TextField(
                                cursorColor: Color(0xff00b661),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Container(
                                    padding: EdgeInsets.only(left: 10, right: 5),
                                    child: Icon(Icons.search, color: Color(0xff054a29),),
                                  ),
                                  suffixIcon: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5, left: 3),
                              decoration: BoxDecoration(
                                color: Color(0xff00b661),
                                shape: BoxShape.circle
                              ),
                              child: IconButton(icon: Icon(Icons.keyboard_arrow_right), iconSize: 25, color: Colors.white, onPressed: onSearchPress, alignment: Alignment.center),
                            ),
                                ),
                              ),
                            ),
                    ),
                    )
                  ),
                ),
          body: Container(
              child:  getScreen(),
            )
      );
    }
    else if(hideBar == 1)
    {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: onAddPress,
          child: Icon(Icons.add),
          backgroundColor: Color(0xff00b661),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
                opacity: .2,
                currentIndex: currentIndex,
                onTap: changePage,
                borderRadius: BorderRadius.zero,
                elevation: 12,
                fabLocation: BubbleBottomBarFabLocation.end,
                hasNotch: false,
                hasInk: true,
                inkColor: Colors.black12,
                items: items
                
              ),
          body: Container(
              child:  getScreen(),
            )
      );
    }
    else
    {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: onAddPress,
          child: Icon(Icons.add),
          backgroundColor: Color(0xff00b661),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
                opacity: .2,
                currentIndex: currentIndex,
                onTap: changePage,
                borderRadius: BorderRadius.zero,
                elevation: 12,
                fabLocation: BubbleBottomBarFabLocation.end,
                hasNotch: false,
                hasInk: true,
                inkColor: Colors.black12,
                items: items
                
              ),
          appBar: AppBar(
              leading: Container(),
                  bottom: PreferredSize(child: Container(), preferredSize: Size.fromHeight(30)),
                  flexibleSpace: FlexibleSpaceBar.createSettings(
                    currentExtent: 20,
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(50))
                              ),
                      child: Container(
                              child: TextField(
                                cursorColor: Color(0xff00b661),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Container(
                                    padding: EdgeInsets.only(left: 10, right: 5),
                                    child: Icon(Icons.search, color: Color(0xff054a29),),
                                  ),
                                  suffixIcon: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5, left: 3),
                              decoration: BoxDecoration(
                                color: Color(0xff00b661),
                                shape: BoxShape.circle
                              ),
                              child: IconButton(icon: Icon(Icons.keyboard_arrow_right), iconSize: 25, color: Colors.white, onPressed: onSearchPress, alignment: Alignment.center),
                            ),
                                ),
                              ),
                            ),
                    ),
                    )
                  ),
                ),
          body: Container(
              child:  getScreen(),
            )
      );
    }
  }

}