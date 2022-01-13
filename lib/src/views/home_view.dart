import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:location/location.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/src/short_calls.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:weather_app/src/views/weather_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var location = Location();

  Future<bool> checkLocation() async {
    bool enabled = await location.serviceEnabled();
    return enabled;
  }

  Future<bool> checkLocationPermission() async {
    PermissionStatus status = await location.hasPermission();
    bool enabled = status == PermissionStatus.granted ||
        status == PermissionStatus.grantedLimited;
    return enabled;
  }

  // ignore: prefer_typing_uninitialized_variables
  var userLocation;
  Future<void> _initLocation() async {
    bool geoEnabled = await checkLocation();
    if (geoEnabled) {
      bool hasPermision = await checkLocationPermission();
      if (hasPermision) {
        location.changeSettings(accuracy: LocationAccuracy.navigation);
        try {
          userLocation = await location.getLocation().catchError((e) {
            log("ERROR: " + e.toString());
          }).timeout(const Duration(seconds: 10), onTimeout: () {
            return userLocation;
          });
        } catch (e) {}
        if (userLocation != null) {
          weatherCotroller.setLatLon(
               userLocation.latitude, userLocation.longitude);
        } else {}
      } else {
        showOptionDialog(
            context: context,
            title: 'Location Permission',
            content: const Text(
                'To get Moovn, Please grant Moovn  access to your location data, we will not share your location with anyone , only the services offered will use your location for a better required experience.'),
            actions: [
              BasicDialogAction(
                title: Text("Grant Permission".toUpperCase()),
                onPressed: () async {
                  Navigator.pop(context);
                  var status = await location.requestPermission();
                  if (status == PermissionStatus.deniedForever ||
                      status == PermissionStatus.denied) {
                    showToast(
                        "You have denied Moovn access to your location data, the app will not function without this permission");
                    geo.Geolocator.openAppSettings();
                  } else {
                    _initLocation();
                  }
                  return;
                },
              ),
            ]);
        return;
      }
    } else {
      showOptionDialog(
          context: context,
          title: 'Location Disabled',
          content: const Text(
              'To get Moovn  Please Enable your location GPS and restart the app'),
          actions: [
            BasicDialogAction(
              title: const Text("LOCATION SETTINGS"),
              onPressed: () async {
                Navigator.pop(context);
                await geo.Geolocator.openLocationSettings();
              },
            ),
          ]);

      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:WeatherView()
    );
    
  }


}
