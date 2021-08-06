import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection reference

  DatabaseService();
  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('ecmrforms');

  Future updateUserData(
      String name,
      String cmrNo,
      String complaint,
      String franchise,
      String stationName,
      String workOrderNo,
      String natureOfComplaint,
      List<dynamic> photos) async {
    Map<String, String> data = {
      'cmrno': cmrNo,
      'complaint': complaint,
      'franchise': franchise,
      'naturecomplaint': natureOfComplaint,
      'stationname': stationName,
      'technician': name,
      'workorderno': workOrderNo
    };
    Map<String, List> photoData = {'cmrPhotos': photos};
    await usercollection.doc(workOrderNo).set(photoData);
    return await usercollection.doc(workOrderNo).set(data);
  }

  Future registerNewUser(
      String username, String email, String firstName, String LastName) async {
    Map<String, String> data = {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': LastName
    };

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .set(data);
  }
}
