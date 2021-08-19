import 'package:blood_donation_system/models/Donor.dart';
import 'package:blood_donation_system/repositories/donor_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DonorRepositoryImpl implements DonorRepository {
  final donorRef = FirebaseFirestore.instance.collection("donors");

  ///Add donor to Firestore
  @override
  Future<void> addDonor(Donor donor) {
    return donorRef.doc(donor.id).set(donor.toJson())
        .then((value) => print('donor added'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Future<Donor> getDonor(String id) async {
    DocumentSnapshot document = await donorRef.doc(id).get();
    if(document.exists){
      return new Donor.fromJson(document.data());
    }
    return null;
  }

  @override
  Future<Donor> getDonorByNIC(String nic) async {
    QuerySnapshot querySnapshot = await donorRef.where('nic', isEqualTo: nic).get();
    if(querySnapshot.size == 1){
      QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs[0];
      return new Donor.fromJson(queryDocumentSnapshot.data());
    }
    return null;
  }

  @override
  Future<void> addDonationRecord(String id, String date) async {
    await donorRef.doc(id).update({'records': FieldValue.arrayUnion([date])});
  }
  
}