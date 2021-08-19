import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorIsNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Image.asset('assets/donor_not_found.jpg',
                width: 200,
              ),
              Text('Donor could not be found. Please try again...'),
              SizedBox(height: 10,),
              RaisedButton(
                child: Text('Go Back'),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
          ],
        ),
      ),
    );
  }
}
