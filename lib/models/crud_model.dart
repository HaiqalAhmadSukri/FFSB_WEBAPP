import 'package:flutter/cupertino.dart';
import 'package:tolonglah/models/station_complaints_model.dart';
import 'package:tolonglah/services/database.dart';
import 'ecmr.dart';
import 'package:provider/provider.dart';

class CRUDModel extends ChangeNotifier {
  Future<List<Ecmr>> fetchEcmr() async {
    var result = await DatabaseService('ecmrforms').getDataCollection();
    List<Ecmr> ecmrList =
        await result.docs.map((e) => Ecmr.fromMap(e.data())).toList();
    return ecmrList;
  }

  Future<List<stationComplaintModel>> fetchStationComplaint() async {
    var result = await DatabaseService('stationComplaints').getDataCollection();
    List<stationComplaintModel> stationComplaints = await result.docs
        .map((e) => stationComplaintModel.fromMap(e.data()))
        .toList();
    return stationComplaints;
  }
}
