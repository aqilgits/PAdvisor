import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:padvisor/loading.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/screen/authenticate/authenticate.dart';
import 'package:padvisor/services/auth.dart';
import 'package:padvisor/services/database.dart';
import 'package:padvisor/models/report_model.dart';
import 'package:provider/provider.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String desc = "";
  String title = "";
  File? file;
  String downloadUrl = '';
  var storage = FirebaseStorage.instance;
  var advisor;
  var setDefaultMake = true, setDefaultMakeModel = true;
  void initState() {
    super.initState();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
    print("file selected");
  }

  fileindicator() {
    if (file == null) {
      return Text("No file selected");
    } else {
      return Text("File selecetd");
    }
  }

  Future uploadFileToFirebase() async {
    var filename = DateTime.now().toString();
    TaskSnapshot snapshot =
        await storage.ref().child("File/$filename").putFile(file!);
    downloadUrl = await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final db = DatabaseService(uid: user!.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('New Report'),
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
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
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
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                      ),
                      onPressed: () {
                        selectFile();
                      },
                      child: const Icon(Icons.upload_file),
                    ),
                    Container(
                      child: fileindicator(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[700],
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () async {
                  await uploadFileToFirebase();
                  await db.createReport(
                      ReportModels(title: title, desc: desc, url: downloadUrl),
                      AuthService().userID,
                      "0");
                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
