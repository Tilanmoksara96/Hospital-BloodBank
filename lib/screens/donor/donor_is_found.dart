import 'package:blood_donation_system/models/Donor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorIsFound extends StatelessWidget {
  final Donor donor;

  const DonorIsFound({Key key, this.donor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: 170,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(donor.fullName,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 5,),Text(donor.occupation,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(height: 5,),
                            SizedBox(height: 5,),Text(donor.nic,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF018786),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Column(
                            children: [
                              Text(donor.bloodGroup,
                                style: Theme.of(context).textTheme.headline2.copyWith(
                                    color: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(donor.dateOfBirth,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 10,),
                  Text(donor.address,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              )
          ),
          Divider(
            thickness: 2,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: donor.records.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF018786),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.all(1),
                      child: Center(
                        child: Text(
                          (i+1).toString(),
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    title: Text(donor.records[i],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
