import 'package:cloud_firestore/cloud_firestore.dart';

class Balcao {
  String name; // name of the model
  int price; //price of the model
  String thumbnail;
  List<dynamic> images; //images of the model
  String description; //description of the model
  int likes;

  Balcao(
      {this.name,
      this.price,
      this.likes,
      this.thumbnail,
      this.images,
      this.description});
}
