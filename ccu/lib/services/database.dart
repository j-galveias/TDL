import 'dart:async';
import 'dart:collection';

import 'package:CCU/models/balcao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference balcaoCollection =
      FirebaseFirestore.instance.collection('balcoes');

  final CollectionReference userBalcaoCollection =
      FirebaseFirestore.instance.collection('user_balcoes');

  final StreamController<List<Balcao>> _balcController =
      StreamController<List<Balcao>>.broadcast();

  late DocumentSnapshot _lastDoc;

  List<List<Balcao>> _allPagedResults = List<List<Balcao>>.empty();

  bool _hasMoreBalcs = true;

  /*Future<bool> checkFavBalc(String name) async {
    DocumentSnapshot doc = await userBalcaoCollection.doc(uid).get();
    try {
      if (doc.get(name) != null) {
        return Future<bool>.value(true);
      }
    } catch (e) {
      return Future<bool>.value(false);
    }
  }*/

  Future addFavBalcao(String name) async {
    await balcaoCollection.doc(name).update({
      'likes': FieldValue.increment(1),
    });
    return await userBalcaoCollection.doc(uid).update({
      name: name,
    });
  }

  Future deleteFavBalcao(String name) async {
    await balcaoCollection.doc(name).update({
      'likes': FieldValue.increment(-1),
    });
    return await userBalcaoCollection.doc(uid).update({
      name: FieldValue.delete(),
    });
  }

  Future getBalc(String key) async {
    return await balcaoCollection.doc(key).get();
  }

  /*Future getFavs() async {
    // TODO: check conflicts with existed field;
    List<Balcao> listOfFavs = [];
    DocumentSnapshot docs = await userBalcaoCollection.doc(uid).get();
    final favs = new SplayTreeMap.from(docs.data());
    for (String key in favs.keys) {
      if (key != 'exists') {
        var doc = await balcaoCollection.doc(key).get();
        listOfFavs.add(Balcao(
            thumbnail: await doc.get('thumbnail'),
            name: await doc.get('name'),
            price: int.parse(await doc.get('price')),
            likes: await doc.get('likes'),
            description: await doc.get('description'),
            images: await doc.get('photos')));
      }
    }
    return listOfFavs;
  }*/

  Future createUserData() async {
    return await userBalcaoCollection.doc(uid).set({
      'exists': true,
    });
  }

  Future updateUserData() async {
    return await userBalcaoCollection.doc(uid).update({
      'exists': true,
    });
  }

  /*Future<List<Map<String, dynamic>>> getNewBalcs() async {
    QuerySnapshot snap =
        await balcaoCollection.orderBy("date", descending: true).limit(3).get();

    List<Map<String, dynamic>> list =
        snap.docs.map((DocumentSnapshot e) => e.data()).toList();

    print(list);

    return list;
  }*/

  Future getAllBalcs() async {
    Query query = balcaoCollection.orderBy('name').limit(11);

    if (_lastDoc != null) {
      query = query.startAfterDocument(_lastDoc);
    }

    if (!_hasMoreBalcs) {
      return;
    }

    int currentRequestIndex = _allPagedResults.length;

    var b = await query.get();

    if (b.docs.isNotEmpty) {
      var a = _balcaoListFromSnapshot(b);

      //does the page exist or not
      var pageExists = currentRequestIndex < _allPagedResults.length;

      //if the page exists update the values to the new balcs
      if (pageExists) {
        _allPagedResults[currentRequestIndex] = a;
      }
      //if the page doesnt exist add the data
      else {
        _allPagedResults.add(a);
      }

      List<Balcao> allBalcs = _allPagedResults.fold<List<Balcao>>(
          List<Balcao>.empty(),
          (initialValue, element) => initialValue..addAll(element));

      //Save the last doc from the results. Only if it's the current last page
      if (currentRequestIndex == _allPagedResults.length - 1) {
        _lastDoc = b.docs.last;
      }

      //determine if there is more balcs to request
      _hasMoreBalcs = a.length == 11;
      print(allBalcs.length);

      return allBalcs;
    }
  }

  Stream<List<Balcao>> get mostPopular {
    return balcaoCollection
        .orderBy("likes", descending: true)
        .limit(3)
        .snapshots()
        .map(_balcaoListFromSnapshot);
  }

  Stream<List<Balcao>> get newBalcs {
    return balcaoCollection
        .orderBy("date", descending: true)
        .limit(3)
        .snapshots()
        .map(_balcaoListFromSnapshot);
  }

  List<Balcao> _balcaoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Balcao(
          thumbnail: doc.get('thumbnail'),
          name: doc.get('name'),
          price: int.parse(doc.get('price')),
          likes: doc.get('likes'),
          description: doc.get('description'),
          images: doc.get('photos'));
    }).toList();
  }
}
