import 'package:flutter/material.dart';

class Report {
  String date; 
  String description; 
  String image;
  String infraction; 
  String licensePlate;
  String location;
  String status;
  String uid;
  String lon;
  String lat;

  Report({
    required this.date,
    required this.description,
    required this.image,
    required this.infraction,
    required this.licensePlate,
    required this.location,
    required this.status,
    required this.uid,
    required this.lat,
    required this.lon,
  });
}
