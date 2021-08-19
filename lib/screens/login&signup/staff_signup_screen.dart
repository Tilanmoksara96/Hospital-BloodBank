import 'package:blood_donation_system/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StaffSignUpScreen extends StatefulWidget {
  @override
  _StaffSignUpScreenState createState() => _StaffSignUpScreenState();
}

class _StaffSignUpScreenState extends State<StaffSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _staffId,_nameWithInitials,_email,_password;
  final AuthService _authService = AuthService();

  Widget _buildStaffIdField(){
    return TextFormField(
      onSaved: (value) {
        _staffId = value;
      },
      decoration: InputDecoration(
        hintText: 'Staff ID',
      ),
      validator: (staffId){
        return StaffIdValidator.staffIdInputFieldValidator(staffId);
      },
    );
  }

  Widget _buildStaffNameWithInitialsField(){
    return TextFormField(
      onSaved: (value) {
        _nameWithInitials = value;
      },
      decoration: InputDecoration(
        hintText: 'Name with initials',
      ),
      validator: (nameWithInitials){
        return NameWithInitialsValidator.nameWithInitialsFieldValidator(nameWithInitials);
      },
    );
  }

  Widget _buildStaffEmailField(){
    return TextFormField(
      onSaved: (value) {
        _email = value;
      },
      decoration: InputDecoration(
        hintText: 'Email',
      ),
      validator: (email){
        return EmailValidator.emailFieldFieldValidator(email);
      },
    );
  }

  Widget  _buildStaffPassword(){
    return TextFormField(
      onSaved: (value) {
        _password = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
      ),
      validator: (password){
        return PasswordValidator.passwordFieldValidator(password);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF018786),
            title: Text('Sign Up'),
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
                        _buildStaffIdField(),
                        _buildStaffNameWithInitialsField(),
                        _buildStaffEmailField(),
                        _buildStaffPassword(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: RaisedButton(
                            child: Container(
                              width: 120,
                              child: Center(
                                child: Text(
                                  'SIGN UP',
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                bool result = await _authService.userRegister(_staffId, _nameWithInitials, _email, _password);
                                if(result) {
                                  _formKey.currentState.reset();
                                  Navigator.pop(context);
                                }else {
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
                                                  Text('Sign up failed. Please try again..',
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

class StaffIdValidator{
  static String staffIdInputFieldValidator(String value){
    if(value.isEmpty){
      return "Staff ID cannot be empty";
    }
    else{
      return null;
    }
  }
}

class NameWithInitialsValidator{
  static String nameWithInitialsFieldValidator(String value){
    if(value.isEmpty){
    return "Name cannot be empty";
    }
    else if(value.length < 5){
    return "Enter a valid name";
    }
    else{
    return null;
    }
  }
}

class EmailValidator{
  static String emailFieldFieldValidator(String value){
    if(value.isEmpty){
      return "Email cannot be empty";
    }
    else if(value.length < 5){
      return "Enter a valid email";
    }
    else{
      return null;
    }
  }
}

class PasswordValidator{
  static String passwordFieldValidator(String value){
    if(value.isEmpty){
      return "Password cannot be empty";
    }
    else if(value.length < 5){
      return "Enter a valid password";
    }
    else{
      return null;
    }
  }
}