import 'package:flutter/material.dart';
import 'package:padvisor/loading.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/services/auth.dart';
import 'package:padvisor/services/database.dart';

class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    final db = DatabaseService(uid: AuthService().userID);
    return FutureBuilder(
        future: DatabaseService(uid: AuthService().userID)
            .getAdvisorCohorts(AuthService().userID),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            List<String>? cohorts = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red[900],
                title: const Text('Graduate'),
              ),
              body: ListView.builder(
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
                            future: DatabaseService.withoutUID().streamStudent(
                                AuthService().userID, cohorts[index]),
                            builder: (context,
                                AsyncSnapshot<List<Student>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else {
                                List<Student>? students = snapshot.data;

                                return ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: students!.length,
                                    itemBuilder: (context, index) {
                                      Student student = students[index];
                                      if (student.archive == false) {
                                        return SizedBox.shrink();
                                      }
                                      return Column(children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 10, 10, 0),
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
                                              onTap: () async {
                                                await db
                                                    .archive(student.id, false)
                                                    .whenComplete(() {
                                                  setState(() {});
                                                });
                                                Navigator.pop(context);
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
            );
          }
        });
  }
}
