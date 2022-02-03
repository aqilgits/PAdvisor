import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Garduate'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.red[900],
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
