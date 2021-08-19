import 'package:blood_donation_system/screens/home/home_screen.dart';
import 'package:blood_donation_system/screens/login&signup/forgot_password_screen.dart';
import 'package:blood_donation_system/screens/login&signup/staff_signup_screen.dart';
import 'package:blood_donation_system/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StaffLoginScreen extends StatefulWidget {
  @override
  _StaffLoginScreenState createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email, _password;

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Email',
      ),
      validator: (email) {
        return EmailValidator.EmailInputFieldValidator(email);
      },
      onSaved: (email) {
        _email = email;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
      ),
      validator: (password) {
          return PasswordValidator.PasswordInputFieldValidator(password);
      },
      onSaved: (password) {
        _password = password;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF018786),
          title: Text('Login'),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              )),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 80,),
                      _buildEmailField(),
                      _buildPasswordField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: RaisedButton(
                          child: Container(
                            width: 120,
                            child: Center(
                              child: Text(
                                'SIGN IN',
                              ),
                            ),
                          ),
                          onPressed: () async{
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              bool result = await _auth.userLogin(_email, _password);
                              if(result){
                                Navigator.pop(context);
                              }
                              else{
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                          height: 140,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text('Login failed. Please try again..',
                                                  style: Theme.of(context).textTheme.subtitle1,
                                                ),
                                                SizedBox(height: 30,),
                                                RaisedButton(
                                                    child: Text('Ok'),
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    }
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                        child: Text(
                            "Have you forgot your password?",
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          child: Text(
                            'Forgot Password',
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailValidator{
  // ignore: non_constant_identifier_names
  static String EmailInputFieldValidator(String value){
    if(value.isEmpty){
      return "Email cannot be empty";
    }
    else if(value.length < 5){
      return "You must enter a valid email";
    }
    else{
      return null;
    }
  }
}

class PasswordValidator{
  // ignore: non_constant_identifier_names
  static String PasswordInputFieldValidator(String value){
    if(value.isEmpty){
      return "Password cannot be empty";
    }
    else if (value.length < 5){
      return "You must enter a valid password";
    }
    else{
      return null;
    }
  }
}
