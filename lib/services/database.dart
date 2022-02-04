import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padvisor/models/announcement_model.dart';
import 'package:padvisor/models/report_model.dart';

class DatabaseService {
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
}
