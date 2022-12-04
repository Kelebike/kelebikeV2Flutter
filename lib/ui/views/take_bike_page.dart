import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelebikev2/ui/views/home_screen.dart';
import 'package:kelebikev2/ui/views/take_bike_with_keyboard.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/constant/style.dart';
import '../../core/services/bike_service.dart';
import 'qr_overlay.dart';

class TakeBikePage extends StatefulWidget {
  @override
  _TakeBikePageState createState() => _TakeBikePageState();
}

class _TakeBikePageState extends State<TakeBikePage> {
  final BikeService _bikeService = BikeService();
  User? _user = FirebaseAuth.instance.currentUser;

  MobileScannerController cameraController = MobileScannerController();
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    var _LockController = TextEditingController();
    Widget _buildLock() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Code:',
            style: kLabelStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: _LockController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                color: Colors.blue,
                fontFamily: 'OpenSans',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.blue,
                ),
                hintText: 'Lock',
                hintStyle: kHintTextStyle,
              ),
            ),
          )
        ],
      );
    }

    Future<void> _takeInCirculation(
        BuildContext context, String barcode) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                  height: 250,
                  child: Column(
                    children: [
                      Text("This bike is already taken."),
                      _buildLock(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            String? bikeLock = await _bikeService.getLock(
                                barcode, _LockController.text);
                            if (bikeLock != null) {
                              await _bikeService.updateOwner(
                                  barcode,
                                  _user!.email.toString(),
                                  DateTime.now().toString());
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Error'),
                                        content: Text('Lock is wrong!'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("OK"),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen()));
                                            },
                                          ),
                                        ],
                                      ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Take Bike',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            );
          });
    }

    return Scaffold(
      backgroundColor: const Color(0xFF6CA8F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6CA8F1),
        elevation: 0,
        title: const Text("Take a bike"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TakeBikeKeyboardPage()));
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
              String? _barcode = barcode.rawValue;
              debugPrint('Barcode Found!${barcode.rawValue!}');
              if (await _bikeService.findWithEmail(_user!.email.toString()) ==
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
              } else if (await _bikeService.findWithBikeCode(_barcode!) ==
                  null) {
                showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                          title: Text('Error'),
                          content: Text('Bike not found!'),
                        ));
              } else if (await _bikeService.isThisBikeTaken(_barcode) == null) {
                _takeInCirculation(context, _barcode);
              } else {
                _bikeService.takeBike(_barcode, _user!.email.toString());
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: const Text('Request successfull'),
                          content: const Text('Your take request has been sent...'),
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
              }
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.7)),
        ],
      ),
    );
  }
}
