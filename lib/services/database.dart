import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  //collection reference
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;
  DatabaseService(this.path) {
    ref = _db.collection(path);
  }
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
      List<String> photos) async {
    Map<String, String> data = {
      'date': DateFormat("dd-MM-yyyy").format(DateTime.now()),
      'cmrno': cmrNo,
      'complaint': complaint,
      'franchise': franchise,
      'naturecomplaint': natureOfComplaint,
      'stationname': stationName,
      'technician': name,
      'workorderno': workOrderNo
    };
    Map<String, List> photoData = {'cmrPhotos': photos};
    List<String> test = [];

    test.add('value');
    test.add('pantat');

    Map<String, List> testMap = {'test': test};

    await ref.doc(workOrderNo).set(data);
    await ref.doc(workOrderNo).update(photoData);
  }

  Future uploadStationComplaint(
    String stationID,
    String stationName,
    String stationAddress,
    String stationComplaint,
    List<String> stationPhotos,
  ) async {
    bool hasTechnician = false;
    bool hasFinished = false;
    Map<String, dynamic> data = {
      'date': DateFormat("dd-MM-yyyy").format(DateTime.now()),
      'stationID': stationID,
      'stationName': stationName,
      'stationComplaint': stationComplaint,
      'stationAddress': stationAddress,
      'stationPhotos': stationPhotos,
      'hasTechnician': hasTechnician,
      'hasFinished': hasFinished
    };
    await ref.add(data);
  }

  Future registerNewUser(
      String username, String email, String firstName, String LastName) async {
    Map<String, String> data = {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': LastName
    };

    return await ref.doc(username).set(data);
  }

  Future testArray() async {
    List<String> test = [];

    test.add('value');
    test.add('pantat');

    Map<String, List> testMap = {'test': test};

    return await FirebaseFirestore.instance
        .collection('test')
        .doc('test')
        .set(testMap);
  }

  Future imagesLink(List names) async {
    Map<String, List> images = {'images': names};

    return await FirebaseFirestore.instance.collection('').doc();
  }

  // get ecmr stream
  Stream<QuerySnapshot> get ecmr {
    return usercollection.snapshots();
  }

  //-----------------------------------------------------------------------//
  //API FUNCTIONS--------------------------------------------------------//

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
}
