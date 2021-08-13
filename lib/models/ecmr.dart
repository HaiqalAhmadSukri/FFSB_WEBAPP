import 'package:cloud_firestore/cloud_firestore.dart';

class Ecmr {
  List<dynamic> cmrPhotos;
  dynamic cmrNo;
  dynamic complaint;
  dynamic date;
  dynamic franchise;
  dynamic natureComplaint;
  dynamic workorderno;
  dynamic stationName;

  Ecmr(
      {required this.cmrPhotos,
      required this.complaint,
      required this.cmrNo,
      required this.date,
      required this.franchise,
      required this.natureComplaint,
      required this.workorderno,
      required this.stationName});

  Ecmr.fromMap(var snapshot)
      : cmrNo = snapshot['cmrno'] ?? ' ',
        cmrPhotos = snapshot['cmrPhotos'] ?? ' ',
        complaint = snapshot['complaint'] ?? ' ',
        date = snapshot['date'] ?? ' ',
        franchise = snapshot['franchise'] ?? ' ',
        natureComplaint = snapshot['naturecomplaint'],
        workorderno = snapshot['workorderno'],
        stationName = snapshot['stationname'];
}
