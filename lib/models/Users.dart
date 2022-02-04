import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String name;
  final String url;
  final String description;

  Users({required this.name, required this.url, required this.description});

  factory Users.fromFireStore(DocumentSnapshot doc) {
    return Users(
      name: doc.id,
      url: doc['url'],
      description: doc['description'],
    );
  }
}
