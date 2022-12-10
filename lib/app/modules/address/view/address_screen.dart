import 'dart:async';
import 'package:crazy_food/app/modules/address/view/widget/botom_add_address.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:flutter_geocoder/geocoder.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AddressScreen> {
  GoogleMapController? mapController = null;
  List<Address>? addressInfo;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  // ignore: deprecated_member_use
  List<LatLng> latlngSegment1 = [];
  Map<MarkerId, Marker> markers = {};
  Set<Marker> _markers = {};
  String? currentLocationText;
  double? currentLatitude;
  double? chooseLongitude;
  double? chooseLatitude;
  double? currentLongitude;
  Location currentLocation = Location();
  List<LatLng> latlng = [];
  late LocationData locationData;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getLocation() async {
    currentLocation.onLocationChanged.listen((LocationData loc) async {
      mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));

      try {
        final coordinates = new Coordinates(loc.latitude, loc.longitude);
        List<Address> add =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        currentLocationText = add[0].addressLine.toString();
        Get.log('loc  ==> ' + add[0].addressLine.toString());
        currentLongitude = loc.longitude;
        currentLatitude = loc.latitude;
      } catch (err) {}
      if (mounted) {
        setState(() {
          _markers.add(
            Marker(
                markerId: const MarkerId('_center.toString()'),
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
          leading: IconButton(
              onPressed: () {
                // Get.to(()=>OrdersDetailsScreen());
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 30,
              )),
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
                BottomAddAdress(
                    true,
                    addressInfo![0],
                    currentLocationText,
                    currentLatitude,
                    currentLongitude,
                    chooseLatitude,
                    chooseLongitude);
                setState(() {
                  chooseLongitude = val.longitude;
                  chooseLatitude = val.latitude;
                });
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
                  margin: const EdgeInsets.all(6),
                  alignment: Alignment.bottomCenter,
                  // padding: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  height: 155,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: BottomAddAdress(
                      true,
                      addressInfo?[0],
                      currentLocationText,
                      currentLatitude,
                      currentLongitude,
                      chooseLatitude,
                      chooseLongitude)),
            ],
          )
        ]),
        // bottomSheet: BottomAddAdress(true,addressInfo?[0]??null,currentLocationText),
      ),
    );
  }

  Future<List<Address>> getAddressData(LatLng val) async {
    final coordinates = Coordinates(val.latitude, val.longitude);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Get.log('loc  2==> ${add[0].addressLine}');
    setState(() {
      addressInfo = add;
    });
    return add;
  }

  addMarkerOnpPoint(LatLng loc) async {
    List<Address> address = await getAddressData(loc);
    setState(() {
      _markers.add(
        Marker(
          onTap: () {},
          markerId: MarkerId(address[0].subAdminArea.toString()),
          position: LatLng(
            loc.latitude,
            loc.longitude,
          ),
        ),
      );
    });
  }
}
