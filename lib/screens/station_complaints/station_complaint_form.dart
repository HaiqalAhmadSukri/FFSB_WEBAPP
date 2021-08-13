import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';
import 'package:tolonglah/models/user.dart';
import 'package:tolonglah/services/auth.dart';
import 'package:tolonglah/services/database.dart';
import 'package:tolonglah/shared/loading.dart';
import 'package:tolonglah/shared/constants.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';

class stationForm extends StatefulWidget {
  @override
  State<stationForm> createState() => _stationFormState();
}

class _stationFormState extends State<stationForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  List<String> stationPhotos = [];
  String stationID = '';
  String stationAddress = '';
  String stationComplaint = '';
  String date = '';
  String stationName = '';
  List<String> fileNames = [];
  var fileBytes = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Loading();
    } else {
      final user = Provider.of<LocalUser?>(context)!.uid;
      return Scaffold(
        backgroundColor: Colors.amber[300],
        appBar: AppBar(
          title: Text('FlowFuel IFM'),
          centerTitle: true,
          backgroundColor: Colors.amber[200],
        ),
        body: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Complaint Form',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Station ID'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an entry' : null,
                      onChanged: (val) {
                        setState(() {
                          stationID = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Station Address'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          stationAddress = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Station Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          stationName = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Station Complaint'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          stationComplaint = val;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            selectFile();
                          });
                        },
                        icon: Icon(Icons.upload),
                        label: Text('Select Images')),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                        onPressed: () async {
                          setState(() => loading = true);
                          dynamic result =
                              await DatabaseService('stationComplaints')
                                  .uploadStationComplaint(
                                      stationID,
                                      stationName,
                                      stationAddress,
                                      stationComplaint,
                                      fileNames);
                          await uploadToFirebase(user);
                          setState(() => loading = false);
                          showUploadSnackbar(context);
                        },
                        icon: Icon(Icons.person),
                        label: Text('Upload Form')),
                    Text('Selected Photos: ' + fileNames.toString())
                  ]),
            ),
          ),
        ),
      );
    }
  }

  Future selectFile() async {
    var result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    for (var imej in result.files) {
      var fileByte = imej.bytes;
      fileBytes.add(fileByte!);
      setState(() {
        var fileName = imej.name;
        fileNames.add(fileName);
      });
    }
  }

  Future? uploadToFirebase(var user) async {
    final dateTime = DateFormat("dd-MM-yyyy").format(DateTime.now());
    FirebaseStorage storange = FirebaseStorage.instance;
    for (var pair in zip([fileBytes, fileNames])) {
      await FirebaseStorage.instance
          .ref('stationComplaints/${pair[1].toString()}')
          .putData(pair[0]);
    }
  }

  void showUploadSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ECMR form has been uploaded!")));
  }
}
