import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future updateUserData(String role, String name, String cohort) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'role': role,
      'cohort': cohort,
    });
  }

  //user data from snapshot
  UserData _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        role: snapshot.get('role'),
        cohort: snapshot.get('cohort'),
        name: snapshot.get('name'));
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDatafromSnapshot);
  }
}
