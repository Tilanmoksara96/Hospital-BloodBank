import 'package:blood_donation_system/models/Donor.dart';
import 'package:blood_donation_system/repositories/donor_repository.dart';
import 'package:blood_donation_system/repositories/firestore/donor_repository_impl.dart';
import 'package:blood_donation_system/screens/donor_registrations/qr_generation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'donor_is_found.dart';
import 'donor_could_not_be_found.dart';

class DonorScreen extends StatefulWidget {
  final String code;
  final String nic;

  const DonorScreen({Key key, this.code, this.nic}) : super(key: key);
  @override
  _DonorScreenState createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  final DonorRepository donorRepository = DonorRepositoryImpl();
  bool isLoading;
  Donor donor;

  @override
  void initState() {
    super.initState();
    if(widget.code != null){
      fetchDonorById(widget.code);
    }

    if(widget.nic != null) {
      fetchDonorByNIC(widget.nic);
    }

    isLoading = true;
  }


  Future<void> fetchDonorById(String id) async {
    Donor donor = await donorRepository.getDonor(id);
    setState(() {
      this.donor = donor;
      isLoading = false;
    });
  }

  Future<void> fetchDonorByNIC(String nic) async {
    Donor donor = await donorRepository.getDonorByNIC(nic);
      setState(() {
        this.donor = donor;
        isLoading = false;
      });
  }

  Future<void> addRecord(String id, List<String> records) async {
    String date = DateTime.now().toLocal().toString().split(' ')[0];
    await donorRepository.addDonationRecord(id, date);
    await fetchDonorById(donor.id);
    Navigator.pop(context);
  }

  void handleOnAddRecord() {
    showDialog(
        context: context,
        builder: (_){
          return Dialog(
            child: Container(
              height: 180,
              child: Column(
                children: [
                  Container(
                    height: 120,
                    child: Center(
                      child: Text("Add blood donation record ?",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          child: Text('Cancel'),
                            onPressed: (){
                              Navigator.pop(context);
                        }),
                        SizedBox(width: 10,),
                        RaisedButton(
                            color: const Color(0xFF018786),
                            child: Text('Ok'),
                            onPressed: (){
                              addRecord(donor.id, donor.records);
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    if(isLoading) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF018786),
            title: Text("Donor Details"),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text('Retrieving donor details.. Please wait...'))
              ],
            ),
          ),
        ),
      );
    }

    if(donor != null) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF018786),
            title: Text("Donor Details"),
          ),
          body: Container(
            child: DonorIsFound(donor: donor,),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                  heroTag: 'qr_fab',
                  backgroundColor: const Color(0xFF018786),
                  child: const Icon(Icons.qr_code),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QRGenerationScreen(donor: donor,)));
                  }),
              SizedBox(height: 10,),
              FloatingActionButton(
                  backgroundColor: const Color(0xFF018786),
                  child: const Icon(Icons.add),
                  onPressed: handleOnAddRecord),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF018786),
          title: Text("Donor Details"),
        ),
        body: DonorIsNotFound(),
      ),
    );
  }
}
