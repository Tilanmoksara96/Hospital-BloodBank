import 'package:blood_donation_system/models/Donor.dart';

abstract class DonorRepository {
  Future<void> addDonor(Donor donor);
  Future<Donor> getDonor(String id);
  Future<Donor> getDonorByNIC(String nic);
  Future<void> addDonationRecord(String id, String date);
}