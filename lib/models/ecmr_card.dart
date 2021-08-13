import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tolonglah/models/crud_model.dart';
import 'package:tolonglah/models/ecmr.dart';
import 'package:tolonglah/shared/loading.dart';

class EcmrCard extends StatelessWidget {
  const EcmrCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Ecmr>> _ecmrList = CRUDModel().fetchEcmr();
    //final ecmr = Provider.of<QuerySnapshot>(context);
    return FutureBuilder<List<Ecmr>>(
        future: _ecmrList,
        builder: (context, _ecmrList) {
          // return Container(
          //   padding: const EdgeInsets.all(12),
          //   child: Text('why is it not working' +
          //       _ecmrList.data![0].cmrPhotos.toString()),
          // );
          if (_ecmrList.hasData) {
            return ListView.builder(
                itemCount: _ecmrList.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 160,
                    child: Card(
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Text('ECMR No.' + (index + 1).toString()),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: ' + _ecmrList.data![index].date),
                                Text('Address: ' +
                                    _ecmrList.data![index].stationName),
                                Text('Franchise: ' +
                                    _ecmrList.data![index].franchise),
                                Text('Work Order No:' +
                                    _ecmrList.data![index].workorderno),
                                Text(
                                    'ECMR No: ' + _ecmrList.data![index].cmrNo),
                                Text('Nature of complaint: ' +
                                    _ecmrList.data![index].natureComplaint),
                                Text('Complaint: ' +
                                    _ecmrList.data![index].complaint),
                              ],
                            ),
                            SizedBox(width: 200),
                            Text('Assigned Technician: Karim'),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.hourglass_bottom))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Loading();
        });
  }
}
