import 'package:blood_donation_system/screens/donor/donor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindDonorScreen extends StatefulWidget {
  @override
  _FindDonorScreenState createState() => _FindDonorScreenState();
}

class _FindDonorScreenState extends State<FindDonorScreen> {
  final _formKey = GlobalKey<FormState>();
  String nic;

  @override
  void initState() {
    super.initState();

  }

  Future<void> findDonor() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DonorScreen(code: null, nic: nic,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF018786),
          title: Text("Find donor"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text("Enter donor NIC",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextFormField(
                        decoration: InputDecoration(),
                        onSaved: (String value){nic = value;},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the donor id';
                          }
                          return null;
                        }
                    )
                  ],
                ),
              ),
            ),
            RaisedButton(
              child: Text("Find"),
              onPressed: findDonor,
            )
          ],
        ),
      ),
    );
  }
}
