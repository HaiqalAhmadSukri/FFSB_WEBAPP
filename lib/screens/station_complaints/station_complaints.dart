import 'package:flutter/material.dart';
import 'package:tolonglah/models/station_complaint_card.dart';
import 'package:tolonglah/services/auth.dart';
import 'package:tolonglah/shared/loading.dart';

class stationComplaint extends StatefulWidget {
  const stationComplaint({Key? key}) : super(key: key);

  @override
  _stationComplaintState createState() => _stationComplaintState();
}

class _stationComplaintState extends State<stationComplaint> {
  final AuthService _auth = AuthService();
  bool loading = false;
  bool isSafetyUser = false;
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Loading();
    } else {
      return Scaffold(
        backgroundColor: Colors.amber[300],
        appBar: AppBar(
          title: const Text('HOME'),
          centerTitle: true,
          backgroundColor: Colors.amber[200],
        ),
        body: const stationComplaintCard(),
      );
    }
  }
}
