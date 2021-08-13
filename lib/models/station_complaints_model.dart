import 'package:cloud_firestore/cloud_firestore.dart';

class stationComplaintModel {
  List<dynamic> stationPhotos;
  dynamic stationID;
  dynamic stationAddress;
  dynamic stationComplaint;
  dynamic date;
  dynamic hasTechnician;
  dynamic hasFinished;

  stationComplaintModel(
      {required this.stationPhotos,
      required this.stationComplaint,
      required this.stationAddress,
      required this.stationID,
      required this.date,
      required this.hasFinished,
      required this.hasTechnician});

  stationComplaintModel.fromMap(var snapshot)
      : stationID = snapshot['stationID'] ?? ' ',
        stationAddress = snapshot['stationAddress'] ?? ' ',
        stationComplaint = snapshot['stationComplaint'] ?? ' ',
        stationPhotos = snapshot['stationPhotos'] ?? ' ',
        date = snapshot['date'] ?? '',
        hasTechnician = snapshot['hasTechnician'],
        hasFinished = snapshot['hasFinished'];
}
