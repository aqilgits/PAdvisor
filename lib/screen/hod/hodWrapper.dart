import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:padvisor/screen/hod/listAnnouncement.dart';
import 'package:padvisor/screen/hod/listReport.dart';
import 'package:padvisor/services/auth.dart';

class HodWrapper extends StatefulWidget {
  const HodWrapper({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<dynamic, dynamic> data;
  @override
  _HodWrapperState createState() => _HodWrapperState();
}

class _HodWrapperState extends State<HodWrapper> {
  Widget? _child;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    _child = ListAnnouncement(data: widget.data);
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
              icon: Icons.home,
              backgroundColor: Colors.grey[200],
              extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.wysiwyg_outlined,
              backgroundColor: Colors.grey[200],
              extras: {"label": "report"}),
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
          _child = ListAnnouncement(data: widget.data);
          break;
        case 1:
          _child = const ListReport();
          break;
      }
    });
  }
}
