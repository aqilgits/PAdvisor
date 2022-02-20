import 'package:flutter/material.dart';
import 'package:padvisor/screen/hod/announcement.dart';

class ListAnnouncement extends StatefulWidget {
  const ListAnnouncement({Key? key}) : super(key: key);

  @override
  _ListAnnouncementState createState() => _ListAnnouncementState();
}

class _ListAnnouncementState extends State<ListAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    "Announcement",
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
                          builder: (context) => const Announcement(),
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
          const SizedBox(height: 15.0),
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                padding: const EdgeInsets.all(11),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2.0),
                          ),
                        ),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Title',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text('lorem ipsum haha'),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
