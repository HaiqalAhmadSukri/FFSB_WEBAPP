class Ecmr {
  List<String> cmrPhotos;
  String cmrNo;
  String complaint;
  String date;
  String franchise;
  String natureComplaint;
  String workorderno;

  Ecmr(
      {required this.cmrPhotos,
      required this.complaint,
      required this.cmrNo,
      required this.date,
      required this.franchise,
      required this.natureComplaint,
      required this.workorderno});

  Ecmr.fromMap(Map snapshot)
      : cmrNo = snapshot['cmrNo'] ?? ' ',
        cmrPhotos = snapshot['cmrPhotos'] ?? ' ',
        complaint = snapshot['complaint'] ?? ' ',
        date = snapshot['date'] ?? ' ',
        franchise = snapshot['franchise'] ?? ' ',
        natureComplaint = snapshot['natureComplaint'],
        workorderno = snapshot['workorderno'];
}
