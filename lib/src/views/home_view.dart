import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
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
  SearchBar? searchBar;
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xffffd5a0).withOpacity(1),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              _showSnack('I wish i could work on this 😢');
              // to lead to favotites but not implemented
            },
            icon: const Icon(
                Icons.favorite)), 
        actions: [searchBar!.getSearchAction(context)]);
  }
// init the serachbar
  _HomeViewState() {
    searchBar = SearchBar(
        closeOnSubmit: false,
        clearOnSubmit: false,
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onChanged: (q) {
          try {
            weatherCotroller.getSearchedLocation(q);
          } catch (e) {
            _showSnack("Something broke");
          }
        },
        onCleared: () {
          weatherCotroller.clearPlaces();
        },
        onClosed: () {});

    searchBar!.isSearching.addListener(() {
      weatherCotroller.updateSearchStatus(searchBar!.isSearching.value);
    });
  }
// called when the user submits the keyed data
  void onSubmitted(String query) {
    _showSnack("Searching...");
    try {
      weatherCotroller.getSearchedLocation(query);
    } catch (e) {
      _showSnack("Something broke");
    }
  }
// randomly collable method for snackbar
  Future<void> _showSnack(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }
// check if the user has enabled gps access
  Future<bool> checkLocation() async {
    bool enabled = await location.serviceEnabled();
    return enabled;
  }
// check if the app has permission to get location data
  Future<bool> checkLocationPermission() async {
    PermissionStatus status = await location.hasPermission();
    bool enabled = status == PermissionStatus.granted ||
        status == PermissionStatus.grantedLimited;
    return enabled;
  }

  // ignore: prefer_typing_uninitialized_variables
  var userLocation;

  @override
  void initState() {
    super.initState();
    // init and get location
    _initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: searchBar?.build(context), body: const WeatherView());
  }

  Future<void> _initLocation() async {
    bool geoEnabled = await checkLocation();
    if (geoEnabled) {
      bool hasPermision = await checkLocationPermission();
      if (hasPermision) {
        location.changeSettings(accuracy: LocationAccuracy.high);
        try {
          // get the user location 
          userLocation = await location.getLocation().catchError((e) {
            
          }).timeout(const Duration(seconds: 10), onTimeout: () {
            return userLocation;
          });
          // ignore: empty_catches
        } catch (e) {}
        if (userLocation != null) {
          // if location is not null, init the data and get weather ata
          weatherCotroller.setLatLon(
              userLocation.latitude, userLocation.longitude);
        } else {}
      } else {
        // tell the user we need this permissin
        showOptionDialog(
            context: context,
            title: 'Location Permission',
            content: const Text(
                'App-Weather needs access to your location in order to show you weather updates'),
            actions: [
              BasicDialogAction(
                title: Text("Grant Permission".toUpperCase()),
                onPressed: () async {
                  Navigator.pop(context);
                  var status = await location.requestPermission();
                  if (status == PermissionStatus.deniedForever ||
                      status == PermissionStatus.denied) {
                    showToast(
                        "You have denied access to your location data, the app will not function without this permission");
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
      // let user enable gps
      showOptionDialog(
          context: context,
          title: 'Location Disabled',
          content:
              const Text('Please Enable your location GPS and restart the app'),
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
}
