import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModels {
  final String title;
  final String details;

  AnnouncementModels({required this.details, required this.title});

  factory AnnouncementModels.fromFireStore(DocumentSnapshot doc) {
    return AnnouncementModels(details: doc['desc'], title: doc['title']);
  }
}
