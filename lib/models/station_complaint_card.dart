import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tolonglah/models/crud_model.dart';
import 'package:tolonglah/models/ecmr.dart';
import 'package:tolonglah/models/station_complaints_model.dart';
import 'package:tolonglah/models/user.dart';
import 'package:tolonglah/shared/loading.dart';
import 'user.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class stationComplaintCard extends StatelessWidget {
  const stationComplaintCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<stationComplaintModel>> _stationComplaintList =
        CRUDModel().fetchStationComplaint();
    Future<List<LocalUser>> ok;
    //final ecmr = Provider.of<QuerySnapshot>(context);
    return FutureBuilder<List<stationComplaintModel>>(
        future: _stationComplaintList,
        builder: (context, _stationComplaintList) {
          // return Container(
          //   padding: const EdgeInsets.all(12),
          //   child: Text('why is it not working' +
          //       _ecmrList.data![0].cmrPhotos.toString()),
          // );
          if (_stationComplaintList.hasData) {
            return ListView.builder(
                itemCount: _stationComplaintList.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    child: Card(
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Text('Complaint No.' + (index + 1).toString()),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Station address:' +
                                    _stationComplaintList
                                        .data![index].stationAddress),
                                Text('Date: ' +
                                    _stationComplaintList.data![index].date),
                                Text('Station ID: ' +
                                    _stationComplaintList
                                        .data![index].stationID),
                                Text('Complaint: ' +
                                    _stationComplaintList
                                        .data![index].stationComplaint),
                              ],
                            ),
                            SizedBox(width: 200),
                            Text('Assigned Technician: '),
                            SizedBox(
                              width: 30,
                            ),
                            _stationComplaintList.data![index].hasFinished
                                ? Icon(Icons.check, color: Colors.green)
                                : Icon(Icons.one_x_mobiledata,
                                    color: Colors.red),
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
