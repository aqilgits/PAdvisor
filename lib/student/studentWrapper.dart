import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:padvisor/student/advisor.dart';
import 'package:padvisor/student/dashboard.dart';

class StudentWrapper extends StatefulWidget {
  const StudentWrapper({Key? key}) : super(key: key);

  @override
  _StudentWrapperState createState() => _StudentWrapperState();
}

class _StudentWrapperState extends State<StudentWrapper> {
  Widget? _child;

  @override
  void initState() {
    _child = const DashboardStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
            color: Colors.white,
            iconSize: 40,
          )
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
    setState(() {
      switch (index) {
        case 0:
          _child = const DashboardStudent();
          break;
        case 1:
          _child = const DashboardStudent();
          break;
        case 2:
          _child = const Advisor();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
