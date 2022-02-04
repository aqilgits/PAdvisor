import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModels {
  final String cohort;
  final String details;

  AnnouncementModels({required this.details, required this.cohort});

  factory AnnouncementModels.fromFireStore(DocumentSnapshot doc) {
    return AnnouncementModels(
      details: doc['details'],
      cohort: doc['cohort'],
    );
  }
}
