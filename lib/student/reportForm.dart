import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;

class ReportForm extends StatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  String desc = "";
  String title = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text("New Report"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Title",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  maxLines: 2,
                  decoration: const InputDecoration.collapsed(
                      hintText: "Enter your description here"),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    desc = value;
                  },
                  maxLines: 20,
                  decoration: const InputDecoration.collapsed(
                      hintText: "Enter your text here"),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Attachment",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection("Report").add({
                      "Title": title,
                      "Desc": desc,
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
