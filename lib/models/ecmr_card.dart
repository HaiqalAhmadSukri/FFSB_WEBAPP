import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EcmrCard extends StatelessWidget {
  const EcmrCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ecmr = Provider.of<QuerySnapshot>(context);
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Text('ECMR FORM '),
            SizedBox(
              width: 20,
            ),
            Text('Work Order No:')
          ],
        ),
      ),
    );
  }
}
