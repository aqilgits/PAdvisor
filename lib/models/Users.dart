import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;

  UserModel({required this.uid});
}

class Student {
  final String name;
  final String role;
  final String cohort;
  final String phonenum;
  final String advisorID;

  Student(
      {required this.role,
      required this.name,
      required this.cohort,
      required this.phonenum,
      required this.advisorID});

  factory Student.fromFireStrore(DocumentSnapshot doc) {
    return Student(
        role: doc['role'],
        name: doc['name'],
        cohort: doc['cohort'],
        phonenum: doc['phone'],
        advisorID: doc['advisor']);
  }
}
