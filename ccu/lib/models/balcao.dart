import 'package:cloud_firestore/cloud_firestore.dart';

class Balcao {
  String name; // name of the model
  int price; //price of the model
  String thumbnail;
  List<dynamic> images; //images of the model
  String description; //description of the model
  int likes;

  Balcao(
      {required this.name,
      required this.price,
      required this.likes,
      required this.thumbnail,
      required this.images,
      required this.description});
}
