import 'package:blood_donation_system/screens/donor_registrations/donator_registrations_screen.dart';
import 'package:blood_donation_system/screens/find_donor/find_donor_screen.dart';
import 'package:blood_donation_system/screens/scan_donor/scan_donor_screen.dart';
import 'package:blood_donation_system/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  void signOut () async {
    await _authService.userLogout();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: (){
                    signOut();
                  },
                )
            ),
            Center(
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text('PersonX',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      SizedBox(height: 90,),
                      Wrap(
                        spacing: 40,
                        runSpacing: 40,
                        alignment: WrapAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ScanDonorScreen()));
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/qrcode.png',
                                  width: 120,
                                ),
                                SizedBox(height: 10,),
                                Text('Scan Donor',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FindDonorScreen()));
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/document.png',
                                  width: 120,
                                ),
                                SizedBox(height: 10,),
                                Text('Find Donor',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DonorRegistrationsScreen()));
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/personalinformation.png',
                                  width: 120,
                                ),
                                SizedBox(height: 10,),
                                Text('Donor\nRegistrations',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
