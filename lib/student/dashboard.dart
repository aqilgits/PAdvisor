import 'package:flutter/material.dart';

class DashboardStudent extends StatefulWidget {
  const DashboardStudent({Key? key}) : super(key: key);

  @override
  _DashboardStudentState createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.centerLeft,
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                "Annoucement",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Text(
              "Information",
            ),
          ),
        ],
      ),
    );
  }
}
