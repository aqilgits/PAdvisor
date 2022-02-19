import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:padvisor/models/announcement_model.dart';
import 'package:padvisor/screen/student/advisor.dart';
import 'package:padvisor/screen/student/dashboard.dart';
import 'package:padvisor/screen/student/report.dart';
import 'package:padvisor/services/auth.dart';

class StudentWrapper extends StatefulWidget {
  StudentWrapper({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<dynamic, dynamic> data;

  @override
  _StudentWrapperState createState() => _StudentWrapperState();
}

class _StudentWrapperState extends State<StudentWrapper> {
  Widget? _child;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    _child = DashboardStudent(data: widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text(
          "PADVISOR",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: const Icon(Icons.person),
            label: const Text('logout'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
        ],
      ),
      body: _child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
              icon: Icons.wysiwyg_outlined,
              backgroundColor: Colors.grey[200],
              extras: {"label": "report"}),
          FluidNavBarIcon(
              icon: Icons.home,
              backgroundColor: Colors.grey[200],
              extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.account_circle_outlined,
              backgroundColor: Colors.grey[200],
              extras: {"label": "advisor"}),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
            iconUnselectedForegroundColor: Colors.red[900],
            barBackgroundColor: Colors.red[900]),
        animationFactor: 0.5,
        scaleFactor: 1.5,
        defaultIndex: 1,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(
      () {
        switch (index) {
          case 0:
            _child = const Report();
            break;
          case 1:
            _child = DashboardStudent(data: widget.data);
            break;
          case 2:
            _child = const Advisor();
            break;
        }
      },
    );
  }
}
