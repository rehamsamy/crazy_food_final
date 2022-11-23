import 'dart:async';
import 'package:crazy_food/app/modules/address/view/widget/botom_add_address.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:flutter_geocoder/geocoder.dart';


class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AddressScreen> {
  GoogleMapController? mapController=null;
List<Address>? addressInfo;
  LatLng _center = const LatLng(45.521563, -122.677433);

  // ignore: deprecated_member_use
  List<LatLng> latlngSegment1 = [];
  Map<MarkerId, Marker> markers = {};
   Set<Marker> _markers = {};
    String ? currentLocationText;


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
        currentLocationText=add[0].addressLine.toString();
        Get.log('loc  ==> '+add[0].addressLine.toString());

      }catch(err){
        print('vvvv =>'+err.toString());
      }

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
               BottomAddAdress(true,addressInfo![0],currentLocationText);
            },
               markers: _markers,
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
                  // padding: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  height: 155,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
                  child: BottomAddAdress(true,addressInfo?[0],currentLocationText)),

            ],
          )

        ]),
         // bottomSheet: BottomAddAdress(true,addressInfo?[0]??null,currentLocationText),
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





}



