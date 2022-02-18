import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:padvisor/screen/adviser/adviserWrapper.dart';
import 'package:padvisor/screen/student/studentWrapper.dart';
import 'package:padvisor/screen/wrapper.dart';
import 'package:padvisor/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/Users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
