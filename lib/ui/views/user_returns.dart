import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelebikev2/ui/views/qr_overlay.dart';
import 'package:kelebikev2/ui/views/user_returns_with_keyboard.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/services/bike_service.dart';
import '../../core/services/history_service.dart';
import 'home_screen.dart';

class ReturnQRPage extends StatefulWidget {
  @override
  _ReturnQRPageState createState() => _ReturnQRPageState();
}

TextEditingController _bikeCodeController = TextEditingController();

class _ReturnQRPageState extends State<ReturnQRPage> {
  final HistoryService _historyService = HistoryService();
  final BikeService _bikeService = BikeService();
  User? _user = FirebaseAuth.instance.currentUser;

  MobileScannerController cameraController = MobileScannerController();
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6CA8F1),
      appBar: AppBar(
        backgroundColor: Color(0xFF6CA8F1),
        elevation: 0,
        title: const Text("Give back the bike"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Return()));
              },
              icon: const Icon(Icons.keyboard)),
          IconButton(
              onPressed: () {
                setState(() {
                  toggle = !toggle;
                });
                cameraController.toggleTorch();
              },
              icon: toggle
                  ? const Icon(Icons.flash_on)
                  : const Icon(Icons.flash_off)),
          IconButton(
              onPressed: () {
                cameraController.switchCamera();
              },
              icon: const Icon(Icons.camera_rear_outlined)),
        ],
        centerTitle: false,
      ),
      body: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) async {
              String? _returnBarcode = barcode.rawValue;
              debugPrint('Barcode Found!${barcode.rawValue!}');
              await _historyService.getBikeWithCode(_returnBarcode!);
              String? docID =
                  await _bikeService.findWithBikeCode(_returnBarcode);

              if (await _bikeService.findWithReturn(_user!.email.toString()) ==
                  1) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('You already have a request.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                            ),
                          ],
                        ));
              } else if (await _bikeService
                      .findWithEmail(_user!.email.toString()) !=
                  1) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('You have no bike.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                            ),
                          ],
                        ));
              } else {
                if (docID == null) {
                  print(docID);
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Bike not found!'),
                            actions: <Widget>[
                               TextButton(
                                child:  const Text("OK"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                              ),
                            ],
                          ));
                } else {
                  await _bikeService.returnBike(_returnBarcode);

                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('Request Succesfull'),
                            content:
                                const Text('Your return request has been sent...'),
                            actions: <Widget>[
                              TextButton(
                                child:  const Text("OK"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                              ),
                            ],
                          ));
                }
              }
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.7)),
        ],
      ),
    );
  }
}
