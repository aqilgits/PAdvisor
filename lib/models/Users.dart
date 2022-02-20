import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;

  UserModel({required this.uid});
}

class Student {
  final String id;
  final String name;
  final String role;
  final String cohort;
  final String phonenum;
  final String advisorID;
  final bool archive;

  Student(
      {this.id = '',
      required this.role,
      required this.name,
      required this.cohort,
      required this.phonenum,
      required this.archive,
      required this.advisorID});

  factory Student.fromFireStrore(DocumentSnapshot doc, {String userId = ''}) {
    return Student(
        id: userId,
        role: doc['role'],
        name: doc['name'],
        cohort: doc['cohort'],
        phonenum: doc['phone'],
        archive: doc['archive'],
        advisorID: doc['advisor']);
  }
}
