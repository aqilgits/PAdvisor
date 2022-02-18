import 'package:flutter/material.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/screen/authenticate/authenticate.dart';
import 'package:padvisor/screen/student/studentWrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    //return either authenticate or home widget
    if (user == null) {
      return Authenticate();
    } else {
      return StudentWrapper();
    }
  }
}
