import 'dart:async';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:flutter_geocoder/geocoder.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapScreen> {
  GoogleMapController? mapController=null;
List<Address>? addressInfo;
  LatLng _center = const LatLng(45.521563, -122.677433);

  // ignore: deprecated_member_use
  List<LatLng> latlngSegment1 = [];
  Map<MarkerId, Marker> markers = {};
   Set<Marker> _markers = {};


  Location currentLocation = Location();
  LatLng _lastMapPosition = const LatLng(45.521563, -122.677433);
  List<LatLng> latlng = [];
  late LocationData locationData;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

  }




  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) async {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));

      try {
        final coordinates = new Coordinates(loc.latitude, loc.longitude);
        List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
        Get.log('loc  ==> '+add[0].addressLine.toString());
        // List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        //   loc.latitude??0,
        //   loc.longitude??0,
        // );
        // print('000 '+(placemarks[0].country).toString());


      }catch(err){
        print('vvvv =>'+err.toString());
      }
      // Get.log('location   =>'+location.
      // locationData=loc;

      print('vvvv '+loc.longitude.toString());
      if (mounted) {

        setState(() {
          _markers.add(
            Marker(
                markerId: MarkerId('_center.toString()'),
                position: LatLng(
                  loc.latitude ?? 0.0,
                  loc.longitude ?? 0.0,
                )),
          );
        });

        // setState(() {
         // _markers.add(
          //   Marker(
          //       markerId: MarkerId('_center.toString()'),
          //       position: LatLng(
          //         loc.latitude ?? 0.0,
          //         loc.longitude ?? 0.0,
          //       )),
          // );
        //     _polyline.add(Polyline(
        //       polylineId: PolylineId(_lastMapPosition.toString()),
        //       visible: true,
        //       //latlng is List<LatLng>
        //       points: latlngSegment1,
        //       // points: latlng,
        //       color: Colors.blue,));
        // });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: AppText(
            'location_map'.tr,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          leading:  IconButton(onPressed: (){
            // Get.to(()=>OrdersDetailsScreen());
           Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 30,)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            onTap: (val) async {
              getAddressData(val);
              addMarkerOnpPoint(val);
              _showDialog(context);

              // BottomAddAdress(true);
            },
            //  polylines: Set<Polyline>.of(polylines.values),
            //   markers: Set<Marker>.of(markers.values),
               markers: _markers,
              //  polylines:_polyline,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 5.0,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  margin: EdgeInsets.all(6),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  height: 240,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppCashedImage(
                        imageUrl: userAvatar,
                        height: 50,
                        width: 50,
                        borderColor: Colors.white,
                        borderWidth: 2,
                        isCircular: true,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'Mohamed Ahmed',
                            color: Colors.white,
                          ),
                          AppText(
                            'hello',
                            color: Colors.grey,
                          ),
                          RatingBar.builder(
                            itemSize: 15,
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.all(6),
                alignment: Alignment.topCenter,
                height: 150,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: AppText(
                              'shipping_details.tr',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            )),
                        Divider(
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             AppCashedImage(
                              imageUrl:
                              'https://knoww.cc/wp-content/uploads/2018/06/2718.jpg',
                              radius: 20,
                              width: 100,
                              height: 70,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                AppText(
                                  'straberrey',
                                  fontSize: 18,
                                ),
                                AppText(
                                  '1.5 kg ',
                                  fontSize: 13,
                                ),
                                AppText(
                                  '150.0 (paid)',
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
        // bottomSheet: BottomAddAdress(true,addressInfo?[0]??null),
      ),
    );
  }


  Future<List<Address>> getAddressData(LatLng val)async{
  final coordinates = new Coordinates(val.latitude, val.longitude);
  List<Address> add =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  Get.log('loc  2==> '+add[0].addressLine.toString());
  setState(() {
    addressInfo=add;
  });
  return add;
  }


  addMarkerOnpPoint(LatLng loc)async{
    List<Address>address=await getAddressData(loc);
    setState(()  {
      _markers.add(
        Marker(
          onTap: (){
          },
            markerId: MarkerId(address[0].subAdminArea.toString()),
            position: LatLng(
              loc.latitude ,
              loc.longitude ,
            ),),
      );
    });
  }

  void _showDialog(BuildContext context) {
    Get.log('alerttt');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("add_address".tr),
          content: Row(
            children: [
              new Text((addressInfo![0].addressLine.toString())),
              Checkbox(value: true, onChanged: (val){
              })
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}







// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
//
//
// const LatLng dest_location = LatLng(37.42796133580664, -122.085749655962);
//


// class _MapScreenState extends State<MapScreen> {
//   Completer<GoogleMapController> _controllerGoogleMap = Completer();
//   late GoogleMapController newGoogleMapController;
//    // Position currentPosition=g.Position(longitude: 0, latitude: 0, timestamp: 0, accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0);
//   var geoLocator = Geolocator();
//   Map<MarkerId, Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   late LocationData locationData;
//   late LatLng _center ;
//
//
//      Location currentLocation = Location();
//
//
//   Future<Position> locatePosition() async {
//
//     return Geolocator.getCurrentPosition(
//         desiredAccuracy: g.LocationAccuracy.high
//          );
//     // setState(() {
//     //   currentPosition = position;
//     // });
//     // print('step1'+currentPosition.toString());
//   }
//
//
//   // getUserLocation() async {
//   //   print('center $_center');
//   //   currentPosition = await locatePosition();
//   //   print('//// '+currentPosition.toString());
//   //   setState(() {
//   //     _center = LatLng(currentPosition.latitude, currentPosition.longitude);
//   //   });
//   //   print('center $_center');
//   // }
//
//
//
//     void getLocation() async {
//     var location = await currentLocation.getLocation();
//     currentLocation.onLocationChanged.listen((LocationData loc) {
//       // mapController?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
//       //   target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
//       //   zoom: 12.0,
//       // )));
//       locationData=loc;
//       print(loc.latitude);
//       print(loc.longitude);
//     // _addMarker(position, id, descriptor)
//     });
//   }
//
//
//
//   static final CameraPosition _UserLocation = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     //target: LatLng(26.0667, 50.5577),
//     zoom: 16,
//   );
//   @override
//   void initState() {
//     super.initState();
//     getLocation();
//     // locatePosition();
//     // getUserLocation();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps'),
//         backgroundColor: Colors.redAccent,
//         leading: new IconButton(
//             icon: new Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => HomeScreen()));
//             }),
//       ),
//       body: GoogleMap(
//         mapType: MapType.normal,
//         myLocationButtonEnabled: true,
//         initialCameraPosition: _UserLocation,
//         polylines: Set<Polyline>.of(polylines.values),
//         markers: Set<Marker>.of(markers.values),
//         myLocationEnabled: true,
//         zoomGesturesEnabled: true,
//         zoomControlsEnabled: true,
//         onMapCreated: (GoogleMapController controller) {
//           _controllerGoogleMap.complete(controller);
//           newGoogleMapController = controller;
//           _getPolyline();
//
//           print('xxx  '+polylines.values.toString());
//           setState(() {});
//         },
//       ),
//     );
//   }
//
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//     Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }
//
//   _addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     print('xxxxx '+id.toString());
//     setState(() {});
//   }
//
//   void _getPolyline() async {
//     // print('step1'+currentPosition.latitude.toString());
//     /// add origin marker origin marker
//     _addMarker(
//       LatLng(locationData.latitude??0.0, locationData.longitude ??0.0),
//       "origin",
//       BitmapDescriptor.defaultMarker,
//     );
//     print('step2');
//     // Add destination marker
//     _addMarker(
//       LatLng(dest_location.latitude, dest_location.longitude),
//       "destination",
//       BitmapDescriptor.defaultMarkerWithHue(90),
//     );
//
//     List<LatLng> polylineCoordinates = [];
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "AIzaSyBaExcwW_EwM9oPWIEZATXGM-N7SUM-yXw",
//       PointLatLng(locationData.latitude??0.0, locationData.longitude??0.0),
//       PointLatLng(dest_location.latitude, dest_location.longitude),
//       travelMode: TravelMode.walking,
//
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         print('jjjj'+polylineCoordinates[0].toString());
//       });
//     } else {
//       print('error r'+result.errorMessage.toString());
//     }
//     _addPolyLine(polylineCoordinates);
//   }
// }
//


