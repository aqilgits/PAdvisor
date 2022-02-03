import 'package:flutter/material.dart';
import 'package:padvisor/adviser/archive.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Advisee',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 220,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    iconSize: 25.0,
                    icon: Icon(Icons.archive_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Archive(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('20/21'),
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                                child: Card(
                                  color: Colors.red[900],
                                  margin: EdgeInsets.fromLTRB(5, 6, 10, 0),
                                  child: ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      'Name',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      'Matric',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              )
                            ]);
                          }),
                    ),
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
