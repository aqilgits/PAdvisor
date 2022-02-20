import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Message extends StatefulWidget {
  final String name;
  final String matric;
  final String cohort;
  const Message(
      {Key? key,
      required this.cohort,
      required this.matric,
      required this.name})
      : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Message'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {},
              child:
                  Icon(Icons.archive_outlined, size: 26, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4),
                child: TextFormField(
                  enabled: false,
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: widget.name,
                  maxLength: 20,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: TextFormField(
                  enabled: false,
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: widget.matric,
                  maxLength: 20,
                  decoration: InputDecoration(
                    labelText: 'Matric',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: TextFormField(
                  enabled: false,
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: widget.cohort,
                  maxLength: 20,
                  decoration: InputDecoration(
                    labelText: 'Cohort',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        openwhatssap();
                      },
                      child: Image.asset('assets/whatssap.png',
                          width: 100, height: 100),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openwhatssap() async {
    var whatsapp = widget.matric;
    var whatsappURl_android = 'https://wa.me/' + whatsapp + '?text=';
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }
}
