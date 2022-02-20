import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/models/announcement_model.dart';
import 'package:padvisor/models/report_model.dart';
import 'package:padvisor/models/Users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  DatabaseService.withoutUID() : uid = "";

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  final FirebaseFirestore _db = FirebaseFirestore.instance;

//create Announcement
  Future<bool> createAnnouncement(AnnouncementModels a, String cohort) async {
    try {
      await _db
          .collection("Cohort")
          .doc(cohort)
          .collection("Announcement")
          .doc(a.title)
          .set({"title": a.title, "desc": a.details});

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

//stream announcement
  Stream<List<AnnouncementModels>> streamAnnouncement(String cohort) {
    dynamic data;
    try {
      data = _db
          .collection("Cohort")
          .doc(cohort)
          .collection("Announcement")
          .snapshots()
          .map((list) => list.docs
              .map((announcement) =>
                  AnnouncementModels.fromFireStore(announcement))
              .toList());
    } catch (e) {
      print(e.toString());
    }
    return data;
  }

//create report
  Future<bool> createReport(ReportModels a, String userID) async {
    try {
      await _db
          .collection("Report")
          .doc(userID)
          .collection("Problems")
          .doc(a.title)
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
  Stream<List<ReportModels>> streamReport(String userID) {
    dynamic data;
    try {
      data = _db
          .collection("Report")
          .doc(userID)
          .collection("Problems")
          .snapshots()
          .map((list) => list.docs
              .map((problems) => ReportModels.fromFireStore(problems))
              .toList());
    } catch (e) {
      print(e.toString());
    }
    return data;
  }

  Future updateUserData(Student a) async {
    dynamic data;
    try {
      data = userCollection.doc(uid).set({
        'name': a.name,
        'role': a.role,
        'cohort': a.cohort,
        'phone': a.phonenum,
        'advisor': a.advisorID,
      });

      data = _db.collection('Student').doc(uid).set({
        'name': a.name,
        'role': a.role,
        'cohort': a.cohort,
        'phone': a.phonenum,
        'advisor': a.advisorID,
      });
    } catch (e) {
      print(e.toString());
    }
    return data;
  }

//retrive student
  Stream<List<Student>> streamStudent() {
    dynamic data;
    try {
      data = _db.collection('Student').snapshots().map((list) => list.docs
          .map((students) => Student.fromFireStrore(students))
          .toList());
    } catch (e) {
      print(e.toString());
    }
    return data;
  }

//------------------------------------------------------------------------------//
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

//upload file tio dtabase
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
