import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tolonglah/models/ecmr.dart';
import 'package:tolonglah/services/database.dart';
import 'package:get_it/get_it.dart';

class CRUDModel extends ChangeNotifier {
  DatabaseService _api = DatabaseService('ecmrforms');

  List<Ecmr> ecmrList = [];

  Future<List<Ecmr>> fetchEcmr() async {
    var result = await _api.getDataCollection();
    ecmrList = await result.docs.map((e) => Ecmr.fromMap(e.data())).toList();
    return ecmrList;
  }
}
