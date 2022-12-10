import 'dart:async';
import 'package:crazy_food/app/data/models/order_model.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:flutter_geocoder/geocoder.dart';

import 'package:url_launcher/url_launcher.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapScreen> {
  GoogleMapController? mapController;
  List<Address>? addressInfo;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  Map map=Get.arguments;
  List<LatLng> latlngSegment1 = [];
  Map<MarkerId, Marker> markers = {};
   final Set<Marker> _markers = {};
   OrderModel ? orderModel;


  Location currentLocation = Location();
  List<LatLng> latlng = [];
  late LocationData locationData;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

  }


  void getLocation(OrderModel? orderModel) async {
    currentLocation.onLocationChanged.listen((LocationData loc) async {
      mapController?.animateCamera(CameraUpdate.newCameraPosition( CameraPosition(
        target: LatLng(orderModel?.latitude ?? 0.0, orderModel?.longitude ?? 0.0),
        zoom: 12.0,
      )));

      try {
        final coordinates = Coordinates(loc.latitude, loc.longitude);
        List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
        Get.log('loc  ==> ${add[0].addressLine}');

      }catch(err){
      }
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
    orderModel=map['order_details'];
    setState(() {
      getLocation(orderModel);
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
          }, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 30,)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
          onTap: (val) async {
            getAddressData(val);
            addMarkerOnpPoint(val);
            _showDialog(context);

          },
             markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 5.0,
            ),
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  margin: const EdgeInsets.all(6),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  height: 240,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const AppCashedImage(
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
                          const AppText(
                            'Mohamed Ahmed',
                            color: Colors.white,
                          ),
                          const AppText(
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
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: ()async{
                          Uri phoneno = Uri.parse('tel:+97798345348734');
                          if (await launchUrl(phoneno)) {
                          //dialer opened
                          }else{
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.all(6),
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
                        const SizedBox(
                          height: 5,
                        ),
                        const Align(
                            alignment: Alignment.topLeft,
                            child: AppText(
                              'shipping_details.tr',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            )),
                        const Divider(
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             AppCashedImage(
                              imageUrl:
                              orderModel?.products?[0].productImage?? 'https://knoww.cc/wp-content/uploads/2018/06/2718.jpg',
                              radius: 20,
                              width: 100,
                              height: 70,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                AppText(
                                  orderModel?.products?[0].productName?? 'straberrey',
                                  fontSize: 18,
                                ),
                                const AppText(
                               '1.5 kg ',
                                  fontSize: 13,
                                ),
                                AppText(
                                  '${  orderModel?.totalAmount} (paid)',
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
      ),
    );
  }


  Future<List<Address>> getAddressData(LatLng val)async{
  final coordinates = Coordinates(val.latitude, val.longitude);
  List<Address> add =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  Get.log('loc  2==> ${add[0].addressLine}');
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
          title: Text("add_address".tr),
          content: Row(
            children: [
               Text((addressInfo![0].addressLine.toString())),
              Checkbox(value: true, onChanged: (val){
              })
            ],
          ),
          actions: <Widget>[

          ],
        );
      },
    );
  }



}








