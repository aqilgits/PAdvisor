import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/models/announcement_model.dart';
import 'package:padvisor/models/report_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  DatabaseService.withoutUID() : uid = "";

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  final FirebaseFirestore _db = FirebaseFirestore.instance;

//create Announcement
  Future<bool> createAnnouncement(AnnouncementModels a) async {
    try {
      await _db.collection("Announcement").add({
        "cohort": a.cohort,
        "details": a.details,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

//stream announcement

//create report
  Future<bool> createReport(ReportModels a) async {
    try {
      await _db
          .collection("Report")
          .doc("9yyC6nX8QbR299ylbVCx")
          .collection("Problems")
          .doc(DateTime.now().microsecondsSinceEpoch.toString())
          .set({
        "url": a.url,
        "Title": a.title,
        "Desc": a.desc,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

//stream report
  Stream<List<String>> streamReport() {
    dynamic data;
    try {
      data = _db
          .collection("Report")
          .doc("9yyC6nX8QbR299ylbVCx")
          .collection("Problems")
          .snapshots()
          .map((list) => list.docs.map((problems) => problems.id).toList());
    } catch (e) {
      print(e.toString());
    }
    return data;
  }

  Future updateUserData(String role, String name, String cohort) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'role': role,
      'cohort': cohort,
    });
  }

  // //user data from snapshot
  // UserData _userDatafromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid,
  //       role: snapshot.get('role'),
  //       cohort: snapshot.get('cohort'),
  //       name: snapshot.get('name'));
  // }

  // //get user doc stream
  // Stream<UserData> get userData {
  //   return userCollection.doc(uid).snapshots().map(_userDatafromSnapshot);
  // }

  Future uploadFileToFirebase(
      String title, String desc, File? file, String uid) async {
    var filename = DateTime.now().toString();
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("File/$filename")
        .putFile(file!);

    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("Reportdummy").add({
        "url": downloadUrl,
        "Title": title,
        "Desc": desc,
        "User": uid,
      });
    } else {
      throw ('error');
    }
  }
}
