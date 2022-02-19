import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padvisor/services/auth.dart';
import 'package:padvisor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/models/report_model.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  String desc = "";
  String title = "";
  File? file;
  String downloadUrl = '';
  var storage = FirebaseStorage.instance;

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
                  onPressed: () async {
                    await uploadFileToFirebase();
                    await db.createReport(
                        ReportModels(
                            title: title, desc: desc, url: downloadUrl),
                        AuthService().userID);
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
