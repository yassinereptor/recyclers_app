import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  LatLng latlngPop;
  
  final Set<Marker> _markers = Set();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          
          GoogleMap(
        mapType: MapType.hybrid,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        markers: _markers,
        onLongPress: (LatLng latlng){
          latlngPop = latlng;
          setState(() {
            _markers.clear();
            _markers.add(Marker(
              markerId: MarkerId('My Location'),
              position: latlng,
            ));
          });
          setState(() async{
             final CameraPosition _pos = CameraPosition(
              bearing: 192.8334901395799,
              target: latlng,
              tilt: 59.440717697143555,
              zoom: 19.151926040649414);
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(_pos));

          });
        },
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10, top: 40),
              child: Wrap(
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    onPressed: onOKPress,
                    color: Color(0xff00b661),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.check, color: Colors.white,),
                          Text("Ok", style: TextStyle(
                            color: Colors.white,
                          fontSize: 18
                          )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: FloatingActionButton.extended(
        
      // ),
    );
  }

  Future<void> onOKPress() async {
    Navigator.of(context).pop(latlngPop);
  }
}