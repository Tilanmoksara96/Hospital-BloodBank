import 'package:blood_donation_system/models/Donor.dart';
import 'package:blood_donation_system/util/image/image_manager.dart';
import 'package:blood_donation_system/util/qr/qr_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class QRGenerationScreen extends StatefulWidget {
  final Donor donor;

  const QRGenerationScreen({Key key, this.donor}) : super(key: key);

  @override
  _QRGenerationScreenState createState() => _QRGenerationScreenState();
}

class _QRGenerationScreenState extends State<QRGenerationScreen> with TickerProviderStateMixin {
  GifController controller1;
  GifController controller2;
  bool isQRSaving = true;
  QRManager qrManager = QRManager();
  ImageManager imageManager = ImageManager();

  Future<void> saveQRCode() async {
      ByteData qrImageData = await qrManager.createQRImage(widget.donor.id);
      final result = await imageManager.saveImageToGallery(qrImageData, widget.donor.fullName);

      if(result) {
        setState(() {
          controller1.stop();
          controller2.animateTo(32, duration: Duration(seconds: 2));
          isQRSaving = false;

        });
      }else{
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('QR code generation failed') ));
      }
  }

  @override
  void initState() {
    super.initState();
    controller1 = GifController(vsync: this);
    controller2 = GifController(vsync: this);
    controller1.repeat(max: 159, min: 1, period: Duration(seconds: 5));
    saveQRCode();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: isQRSaving? SavingQR(context) : QRSaved(context),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget SavingQR(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GifImage(
            gaplessPlayback: true,
            controller: controller1,
            image: AssetImage("assets/animations/qr-saving.gif"),
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          SizedBox(height: 10,),
          Text("Saving QR code.. Please wait!")
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget QRSaved(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GifImage(
            gaplessPlayback: true,
            controller: controller2,
            image: AssetImage("assets/animations/qr-saved.gif"),
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          SizedBox(height: 10,),
          Text("QR code was saved successfully!"),
          SizedBox(height: 20,),
          RaisedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Go back'),
          )
        ],
      ),
    );
  }
}
