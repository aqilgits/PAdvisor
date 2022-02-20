import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padvisor/loading.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/models/announcement_model.dart';
import 'package:padvisor/screen/adviser/adviserWrapper.dart';
import 'package:padvisor/screen/authenticate/authenticate.dart';
import 'package:padvisor/screen/hod/announcement.dart';
import 'package:padvisor/screen/hod/hodWrapper.dart';
import 'package:padvisor/screen/student/studentWrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  _WrapperState createState() {
    return _WrapperState();
  }
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    //return either authenticate or home widget
    if (user == null) {
      return const Authenticate();
    } else {
      return FutureBuilder(
          future: users.doc((FirebaseAuth.instance.currentUser!).uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map data = (snapshot.data!.data() ?? {}) as Map;
              if (data['role'] == 'Student' || data['role'] == 'student') {
                return StudentWrapper(data: data);
              } else if (data['role'] == 'Advisor' ||
                  data['role'] == 'advisor') {
                return AdviserWrapper(data: data);
              } else {
                return HodWrapper();
              }
            }
            return Loading();
          });
    }
  }
}
