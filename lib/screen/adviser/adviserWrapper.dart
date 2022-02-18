import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:padvisor/screen/adviser/listAnnouncement.dart';
import 'package:padvisor/screen/adviser/listReport.dart';
import 'package:padvisor/screen/adviser/listStudent.dart';

class AdviserWrapper extends StatefulWidget {
  const AdviserWrapper({Key? key}) : super(key: key);

  @override
  _AdviserWrapperState createState() => _AdviserWrapperState();
}

class _AdviserWrapperState extends State<AdviserWrapper> {
  Widget? _child;

  @override
  void initState() {
    _child = const ListAnnouncement();
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
              icon: Icons.home,
              backgroundColor: Colors.grey[200],
              extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.wysiwyg_outlined,
              backgroundColor: Colors.grey[200],
              extras: {"label": "notice"}),
          FluidNavBarIcon(
              icon: Icons.people_sharp,
              backgroundColor: Colors.grey[200],
              extras: {"label": "advisee"}),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
            iconUnselectedForegroundColor: Colors.red[900],
            barBackgroundColor: Colors.red[900]),
        animationFactor: 0.5,
        scaleFactor: 1.5,
        defaultIndex: 0,
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
          _child = const ListAnnouncement();
          break;
        case 1:
          _child = const ListReport();
          break;
        case 2:
          _child = const ListStudent();
          break;
      }
    });
  }
}
