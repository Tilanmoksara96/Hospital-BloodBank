import 'package:blood_donation_system/screens/login&signup/staff_login_screen.dart';
import 'package:blood_donation_system/screens/login&signup/staff_signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GuestHomeScreen extends StatelessWidget {
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
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('PersonX',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 50,),
                    Image.asset('assets/teamwork.png',
                      width: 200,
                    ),
                    SizedBox(height: 50,),
                    RaisedButton(
                        child: Container(
                          width: 80,
                          child: Center(
                              child: Text('Register')),
                        ),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StaffSignUpScreen()));
                        }
                    ),
                    RaisedButton(
                        child: Container(
                          width: 120,
                          child: Center(
                              child: Text('Login')),
                        ),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StaffLoginScreen()));
                        }
                        ),
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
