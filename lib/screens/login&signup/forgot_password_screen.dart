import 'package:blood_donation_system/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String _email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF018786),
          title: Text('Forgot Password'),
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
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      TextFormField(
                        onSaved: (value) {
                          _email = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email address',
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Email cannot be empty";
                          }
                          else if(value.length < 5){
                            return "Enter a valid email";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            child: Container(
                              width: 120,
                              child: Center(
                                child: Text(
                                  'Send reset link',
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print(_email);
                                bool result = await _authService.sendPasswordResetLink(_email);
                                String dialogText;
                                if(result) {
                                  _formKey.currentState.reset();
                                  dialogText = 'Password reset link has been sent';
                                }else {
                                  dialogText = 'Error has occurred. Please try again';
                                }
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
                                                Text(dialogText,
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
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      );
  }
}
