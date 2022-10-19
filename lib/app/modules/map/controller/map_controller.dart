import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class MapController extends GetxController{
  Location currentLocation = Location();
  GoogleMapController? mapController=null;
  late LocationData locationData;


  @override
  void onInit() {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    getLocation();
    update();
  }


  void getLocation() async {
    Get.log('bbbbbbbbb');
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      locationData=loc;
  update();
      print('vvvv '+loc.longitude.toString());
      // if (mounted) {
      //
      //   // setState(() {
      //   //   _markers.add(
      //   //     Marker(
      //   //         markerId: MarkerId('_center.toString()'),
      //   //         position: LatLng(
      //   //           loc.latitude ?? 0.0,
      //   //           loc.longitude ?? 0.0,
      //   //         )),
      //   //   );
      //   //     _polyline.add(Polyline(
      //   //       polylineId: PolylineId(_lastMapPosition.toString()),
      //   //       visible: true,
      //   //       //latlng is List<LatLng>
      //   //       points: latlngSegment1,
      //   //       // points: latlng,
      //   //       color: Colors.blue,));
      //   // });
      // }
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
   update();

  }

}