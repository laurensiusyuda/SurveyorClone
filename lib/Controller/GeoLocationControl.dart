// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_null_comparison

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationController extends GetxController {
  //! Get location
  var currentAddress = ''.obs;
  var longitude = ''.obs;
  var latitude = ''.obs;
  late final Position currentPosition;

  //! Get date time
  var formattedDate = ''.obs;
  var formattedTime = ''.obs;
  late DateTime now;

  @override
  void onInit() {
    super.onInit();
    now = DateTime.now();
    getCurrentPosition();
    updateFormattedDateTime(now);
  }

  //! Handle location permission
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.dialog(
        const Text(
          "Location services are disabled. Please enable the services",
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.dialog(
          const Text(
            "Location permissions are denied",
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (permission == LocationPermission.denied) {
        Get.dialog(
          const Text(
            "Location permissions are permanently denied, we cannot request permissions.",
          ),
        );
        return false;
      }
    }
    return true;
  }

  //! Get current datetime
  Future<void> updateFormattedDateTime(DateTime dateTime) async {
    formattedDate.value =
        '${dateTime.year.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    formattedTime.value =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  //! Get current position
  Future<void> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return;
      final currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      //! Retrieve latitude and longitude data
      longitude.value = "${currentPosition.longitude}";
      latitude.value = "${currentPosition.latitude}";
      getAddressFromLatLng(currentPosition);
    } catch (e) {
      print(e);
    }
  }

  //! Get address from latitude and longitude
  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        //! Convert longtitude to latitude
        currentAddress.value =
            "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
      }
    } catch (e) {
      print(e);
    }
  }
}
