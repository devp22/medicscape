import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double latitude = 40.712776;
  double longitude = -74.005974;
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(40.712776, -74.005974),
    zoom: 14.4746,
  );
  CameraPosition currentLocation = const CameraPosition(
    target: LatLng(40.712776, -74.005974),
    zoom: 14.4746,
  );
  @override
  void initState() {
    print("init state begins");
    super.initState();

    getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCurrentLocation() async {
    print("in current location");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print("geolocator worked");
    currentLocation = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  getCurrentPosition() async {
    print("in getcurrentposition");
    final GoogleMapController controller = await _controller.future;
    await getCurrentLocation();
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(currentLocation),
    );
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark addresses = placemarks[0];
    print("Current location is: ");
    print("latitude: ${latitude}");
    print("longitude: ${longitude}");
    print("Feature name is ${addresses.name}");
    print("Street is ${addresses.street}");
    print("Country is ${addresses.country}");
    print("locality is ${addresses.locality}");
    print("sublocality is ${addresses.subLocality}");
    print("admin area area is ${addresses.administrativeArea}");
    print("sub admin area is ${addresses.subAdministrativeArea}");
    Future.delayed(const Duration(seconds: 10), () {
      // Do something
      Navigator.pushNamed(context, '/loadhospitals', arguments: {
        // "latitude": latitude,
        // "longitude": longitude,
        // "country": addresses.country,
        "city": addresses.locality,
        "sublocality": addresses.subLocality,
        // "feature name": addresses.name,
        // "administrative area": addresses.administrativeArea,
        // "subadministrative area": addresses.subAdministrativeArea,
        // "street": addresses.street
      });
    });

    // print("Address Line is ${addresses.first.addressLine}");
  }

  getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // ignore: unrelated_type_equality_checks
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg:
                "You can't use this app without location access. This app will be automatically closed");
        Future.delayed(const Duration(seconds: 5), exit(0));
      }
    } else {
      getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: false,
        mapType: MapType.satellite,
        compassEnabled: true,
        mapToolbarEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // ignore: prefer_const_constructors
      floatingActionButton: FloatingActionButton.extended(
        onPressed: getCurrentPosition,
        label: Text(
          'Current Location',
          style: GoogleFonts.aBeeZee(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(
          Icons.location_pin,
          color: Colors.black,
        ),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
