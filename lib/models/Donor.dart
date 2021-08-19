import 'package:uuid/uuid.dart';

class Donor {
  String id;
  String fullName;
  String dateOfBirth;
  String occupation;
  String nic;
  String address;
  String bloodGroup;
  List<String> records;

  Donor({this.id, this.fullName, this.dateOfBirth, this.occupation, this.nic,
    this.address, this.bloodGroup, this.records});

  Donor.newDonor({this.fullName, this.dateOfBirth, this.occupation, this.nic,
      this.address, this.bloodGroup,}) {
      var uuid = Uuid();
      this.id = uuid.v1();
      this.records = [];
  }

  Donor.fromJson(Map<String, dynamic> json)
      : this(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      occupation: json['occupation'] as String,
      address: json['address'] as String,
      nic: json['nic'] as String,
      bloodGroup: json['bloodGroup'] as String,
      records: List<String>.from(json['records'])
  );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'occupation': occupation,
      'nic': nic,
      'bloodGroup': bloodGroup,
      'address': address,
      'records': records.toList()
    };
  }
}