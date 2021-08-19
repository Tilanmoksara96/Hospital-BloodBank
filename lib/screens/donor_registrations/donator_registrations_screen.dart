import 'package:blood_donation_system/models/Donor.dart';
import 'package:blood_donation_system/repositories/donor_repository.dart';
import 'package:blood_donation_system/repositories/firestore/donor_repository_impl.dart';
import 'package:blood_donation_system/screens/donor_registrations/qr_generation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorRegistrationsScreen extends StatefulWidget {
  @override
  _DonorRegistrationsScreenState createState() => _DonorRegistrationsScreenState();
}

class _DonorRegistrationsScreenState extends State<DonorRegistrationsScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String fullName;
  String nic;
  String address;
  String occupation;
  String bloodGroup;

  final DonorRepository donorRepository = new DonorRepositoryImpl();

  ///handle on select date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  ///handle on register donor
  void registerDonor() {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      Donor donor = Donor.newDonor(
        fullName: fullName,
        nic: nic,
        occupation: occupation,
        address: address,
        dateOfBirth: selectedDate.toLocal().toString().split(' ')[0],
        bloodGroup: bloodGroup,
      );
      donorRepository.addDonor(donor)
        .then((value) {
          _formKey.currentState.reset();
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>QRGenerationScreen(donor: donor,)));
        })
        .catchError((error) {
          print('screen error');
      });
    }else{
      print('invalid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF018786),
          title: Text('Donor Registration Form'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              RegisterForm(context),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  color: const Color(0xFF018786),
                    onPressed: ()=>{registerDonor()},
                    child: Text('Register',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///Donor register form
  // ignore: non_constant_identifier_names
  Widget RegisterForm(BuildContext context) {
    return  Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              decoration: InputDecoration(),
              onSaved: (String value){fullName = value;},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the donor name';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date of Birth",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(height: 20.0,),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),],
                )
              ],
            ),
            SizedBox(height: 20,),
            Text("Address",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              onSaved: (String value){address = value;},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the address';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            Text("Occupation",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              onSaved: (String value){occupation = value;},
            ),
            SizedBox(height: 20,),
            Text("NIC No",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              onSaved: (String value){nic = value;},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the NIC No';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            Text("Blood Group",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              onSaved: (String value){bloodGroup = value;},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the blood group';
                }
                return null;
              },
            ),
          ],

        ));
  }
}
