import 'package:blood_donation_system/screens/donor/donor_screen.dart';
import 'package:blood_donation_system/screens/scan_donor/scanner_not_started.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class ScanDonorScreen extends StatefulWidget {
  @override
  _ScanDonorScreenState createState() => _ScanDonorScreenState();
}

class _ScanDonorScreenState extends State<ScanDonorScreen> {
  bool _isScanning;

  @override
  void initState() {
    super.initState();
    _isScanning = true;
  }

  void readQRCode(String code) {
    setState(() {
      _isScanning = false;
    });
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DonorScreen(code: code, nic: null,)));
  }

  @override
  Widget build(BuildContext context) {
    if(_isScanning) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF018786),
            title: Text("Scan Donor"),
          ),
          body: Container(
            child: QRBarScannerCamera(
              notStartedBuilder: (context){
                return ScannerNotStarted();
              },
              onError: (context, error) => Text(
                error.toString(),
                style: TextStyle(color: Colors.red),
              ),
              qrCodeCallback: (code) {
                readQRCode(code);
              },
            )
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF018786),
          title: Text("Scan Donor"),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _isScanning = true;
                    });
                  },
                  child: Image.asset('assets/scan_again.jpg',
                    width: 200,
                  ),
                ),
                RaisedButton(
                  color: const Color(0xFF018786),
                  child: Text("Scan again",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                    onPressed: (){
                      setState(() {
                        _isScanning = true;
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
