import 'package:flutter/material.dart';
import 'package:padvisor/loading.dart';
import 'package:padvisor/screen/adviser/archive.dart';
import 'package:padvisor/screen/adviser/message.dart';
import 'package:padvisor/services/auth.dart';
import 'package:padvisor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:padvisor/models/Users.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService(uid: AuthService().userID)
            .getAdvisorCohorts(AuthService().userID),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            List<String>? cohorts = snapshot.data;
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
                      itemCount: cohorts?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(cohorts![index]),
                            ),
                            Container(
                              padding: EdgeInsets.all(0),
                              child: FutureBuilder(
                                  future: DatabaseService.withoutUID()
                                      .streamStudent(
                                          AuthService().userID, cohorts[index]),
                                  builder: (context,
                                      AsyncSnapshot<List<Student>> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else {
                                      List<Student>? students = snapshot.data;

                                      return ListView.builder(
                                          physics:
                                              const ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: students!.length,
                                          itemBuilder: (context, index) {
                                            Student student = students[index];
                                            if (student.archive == true) {
                                              return SizedBox.shrink();
                                            }
                                            return Column(children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 10, 10, 0),
                                                child: Card(
                                                  color: Colors.red[900],
                                                  margin: EdgeInsets.fromLTRB(
                                                      5, 6, 10, 0),
                                                  child: ListTile(
                                                    leading: Icon(Icons.person),
                                                    title: Text(
                                                      student.name,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: Text(
                                                      student.phonenum,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Message(
                                                                        name: student
                                                                            .name,
                                                                        matric:
                                                                            student.phonenum,
                                                                        cohort:
                                                                            student.cohort,
                                                                        id: student
                                                                            .id,
                                                                      )));
                                                    },
                                                  ),
                                                ),
                                              )
                                            ]);
                                          });
                                    }
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
        });
  }
}
