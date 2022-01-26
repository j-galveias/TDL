import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:CCU/models/policeUser.dart';
import 'package:CCU/models/report.dart';
import 'package:CCU/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference reportCollection =
      FirebaseFirestore.instance.collection('reports');

  final CollectionReference userReportCollection =
      FirebaseFirestore.instance.collection('user_reports');

  //final StreamController<List<Balcao>> _balcController =
      //StreamController<List<Balcao>>.broadcast();

  DocumentSnapshot? _lastDoc;

  List<List<Report>> _allPagedResults = [];

  bool _hasMoreReports = true;

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

  /*Future addFavBalcao(String name) async {
    await balcaoCollection.doc(name).update({
      'likes': FieldValue.increment(1),
    });
    return await userBalcaoCollection.doc(uid).update({
      name: name,
    });
  }*/

  /*Future deleteFavBalcao(String name) async {
    await balcaoCollection.doc(name).update({
      'likes': FieldValue.increment(-1),
    });
    return await userBalcaoCollection.doc(uid).update({
      name: FieldValue.delete(),
    });
  }*/

  /*Future getBalc(String key) async {
    return await balcaoCollection.doc(key).get();
  }*/

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

  Future<String> uploadImage(File image, String path) async {
    try{
      final ref = FirebaseStorage.instance.ref(path);
      var task = ref.putFile(image);
      if(task == null){return "";}
      final snapshot = await task.whenComplete(() => {});
      return await snapshot.ref.getDownloadURL();
    }on FirebaseException catch(e){
      print(e);
      return '';
    }
  }

  Future createReportData(
    String infraction, String licensePlate, String location, String description, File image, String date, String lon, String lat) async {
      var downloadUrl = await uploadImage(image, 'reportsImages/${basename(image.path)}');

      var id = DateTime.now().toString();
      await reportCollection.doc(id).set({
        'uid': uid,
        'infraction': infraction,
        'license_plate': licensePlate,
        'date': id,
        'location': location,
        'description': description,
        'image': downloadUrl,
        'status': "To be reviewed",
        'lat': lat,
        'lon': lon,
      });

      await updateUserData(date);
      return await updatePoliceUserData();
  }

  Future createPoliceUserData() async {
    return await userReportCollection.doc('police').set({
      'exists': true,
      'total_reports': 0,
      'reports_to_be_reviewed': 0,
    });
  }

  Future createUserData(String name, String email, String licensePlate) async {
    return await userReportCollection.doc(uid).set({
      'exists': true,
      'name': name,
      'email': email,
      'license_plate': licensePlate,
      'daily_reports': 0,
      'license_points': 12,
      'reward_points': 0,
      'total_reports': 0,
      'approved': 0,
      'last_report': '',
    });
  }

  Future updateUserData(String date) async {
    return await userReportCollection.doc(uid).update({
      'total_reports': FieldValue.increment(1),
      'daily_reports': FieldValue.increment(1),
      'last_report': date,
    });
  }

  Future updateUserDataDailyRep() async {
    return await userReportCollection.doc(uid).update({
      'daily_reports': 0,
    });
  }

  Future updatePoliceUserData() async {
    return await userReportCollection.doc('police').update({
      'total_reports': FieldValue.increment(1),
      'reports_to_be_reviewed': FieldValue.increment(1),
    });
  }

  // get user doc stream
  Stream<UserData> get userData{
    return userReportCollection.doc(uid).snapshots().map(_userData);
  }

// get police user doc stream
  Stream<PoliceUserData> get policeUserData{
    return userReportCollection.doc('police').snapshots().map(_policeUserData);
  }
  
  // userData from snapshot
  PoliceUserData _policeUserData(DocumentSnapshot snapshot){
    var a = PoliceUserData(
      uid: uid!,
      total_reports: snapshot.get('total_reports'),
      reports_to_be_reviewed: snapshot.get('reports_to_be_reviewed'),
    );
    return a;
  }

  // userData from snapshot
  UserData _userData(DocumentSnapshot snapshot){
    var a = UserData(
      uid: uid!,
      name: snapshot.get('name'),
      licensePlate: snapshot.get('license_plate'),
      dailyReports: snapshot.get('daily_reports'),
      totalReports: snapshot.get('total_reports'),
      rewardPoints: snapshot.get('reward_points'),
      licensePoints: snapshot.get('license_points'),
      approved: snapshot.get('approved'),
      last_report: snapshot.get('last_report'),
    );
    return a;
  }

  /*Future<List<Map<String, dynamic>>> getNewBalcs() async {
    QuerySnapshot snap =
        await balcaoCollection.orderBy("date", descending: true).limit(3).get();

    List<Map<String, dynamic>> list =
        snap.docs.map((DocumentSnapshot e) => e.data()).toList();

    print(list);

    return list;
  }*/

  Future getAllReports(bool isPolice) async {
    Query query;
    if(isPolice){
      query = reportCollection.orderBy('date');
    }else{
      query = reportCollection.where('uid', isEqualTo: this.uid).orderBy('date');
    }

    var b;
    try{
      b = await query.get();

    }catch(e){
      print(e.toString());
      return;
    }

    if (b.docs.isNotEmpty) {
      var a = _reportListFromSnapshot(b);

      _allPagedResults.add(a);

      List<Report> allReports = _allPagedResults.fold<List<Report>>(
          [],
          (initialValue, element) => initialValue..addAll(element));


      print(allReports.length);

      return allReports;
    }
  }

  Future getAllReportsNoLimit() async {
    Query query;
    query = reportCollection.orderBy('date');

    int currentRequestIndex = _allPagedResults.length;

    var b;
    try{
      b = await query.get();

    }catch(e){
      print(e.toString());
      return;
    }

    if (b.docs.isNotEmpty) {
      var a = _reportListFromSnapshot(b);

      return a;
    }
  }

  Future<String> updateReport(Report report, String status) async {
    String name = '';
    await reportCollection.doc(report.date).update({
      'status': status,
    });
    await userReportCollection.doc('police').update({
      'reports_to_be_reviewed': FieldValue.increment(-1),
    });
    if(status == "Accepted"){
      var doc = await userReportCollection.where('license_plate', isEqualTo: report.licensePlate).get();

      if(doc.docs.length <= 0){
        return name;
      }

      UserData rep = _userData(doc.docs[0]);

      var newPoints = max(0, rep.licensePoints - 1);
      //name = rep.name;

      await userReportCollection.doc(doc.docs[0].reference.id).update({
        'license_points': newPoints,
      });
      await userReportCollection.doc(report.uid).update({
        'reward_points': FieldValue.increment(1),
        'approved': FieldValue.increment(1),
      });
    }
    return name;
  }

  List<Report> _reportListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Report(
        uid: doc.get('uid'),
        infraction: doc.get('infraction'),
        licensePlate: doc.get('license_plate'),
        date: doc.get('date'),
        location: doc.get('location'),
        description: doc.get('description'),
        image: doc.get('image'),
        status: doc.get('status'),
        lat: doc.get('lat'),
        lon: doc.get('lon'),
      );
    }).toList();
  }

  /*List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
        uid: doc.get('uid'),
        name: doc.get('name'),
        licensePlate: doc.get('license_plate'),
        dailyReports: doc.get('daily_reports'),
        totalReports: doc.get('total_reports'),
        rewardPoints: doc.get('reward_points'),
        licensePoints: doc.get('license_points'),
        approved: doc.get('approved'),
      );
    }).toList();
  }*/
}
