import 'package:flutter/material.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/screen/hod/report.dart';
import 'package:padvisor/screen/hod/viewReport.dart';
import 'package:padvisor/screen/student/problem_details.dart';
import 'package:padvisor/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:padvisor/services/database.dart';
import 'package:padvisor/models/report_model.dart';

class ListReport extends StatefulWidget {
  const ListReport({Key? key}) : super(key: key);

  @override
  _ListReportState createState() => _ListReportState();
}

class _ListReportState extends State<ListReport> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    return StreamProvider<List<ReportModels>>.value(
        value:
            DatabaseService(uid: user!.uid).streamReport(AuthService().userID),
        catchError: (_, __) => [],
        initialData: [],
        builder: (context, child) {
          return Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Report",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              primary: Colors.red[900],
                              shadowColor: Colors.red[900]),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Report(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                      ],
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
                const SizedBox(height: 20.0),
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: Provider.of<List<ReportModels>>(context).length,
                  itemBuilder: (context, index) {
                    ReportModels problems =
                        Provider.of<List<ReportModels>>(context)
                            .elementAt(index);
                    return Card(
                      color: Colors.red[900],
                      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                      child: ListTile(
                        title: Text(
                          problems.title,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Status',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProblemDetails(
                                  title: problems.title, desc: problems.desc),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
