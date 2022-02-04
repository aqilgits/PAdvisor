import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModels {
  final String title;
  final String desc;
  final String url;

  ReportModels({required this.title, required this.desc, required this.url});

  factory ReportModels.fromFireStore(DocumentSnapshot doc) {
    return ReportModels(
      title: doc['title'],
      desc: doc['desc'],
      url: doc['url'],
    );
  }
}
