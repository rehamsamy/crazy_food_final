import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class AddressController extends GetxController{
  Location currentLocation = Location();
  GoogleMapController? mapController=null;
  late LocationData locationData;


  @override
  void onInit() {
    super.onInit();
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    getLocation();
    update();
  }


  void getLocation() async {
    // var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      locationData=loc;
  update();
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
   update();

  }

}