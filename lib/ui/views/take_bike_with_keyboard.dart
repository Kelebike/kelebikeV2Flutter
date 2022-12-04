import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelebikev2/ui/views/home_screen.dart';
import '../../core/constant/style.dart';
import '../../core/services/bike_service.dart';

class TakeBikeKeyboardPage extends StatefulWidget {
  @override
  _TakeBikeKeyboardPageState createState() => _TakeBikeKeyboardPageState();
}

TextEditingController _bikeCodeController = TextEditingController();
Widget _buildBikeCode() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: bikeCodeDecorationStyle,
        height: 60.0,
        width: double.infinity,
        child: TextField(
          controller: _bikeCodeController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
            hintText: 'bike code',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

class _TakeBikeKeyboardPageState extends State<TakeBikeKeyboardPage> {
  final BikeService _bikeService = BikeService();
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF6CA8F1),
        elevation: 0,
        title: const Text("Take a bike"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: _buildBikeCode(),
            ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xFF6CA8F1)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 15))),
              onPressed: () async {
                if (await _bikeService
                        .findWithEmail(_user!.email.toString()) ==
                    1) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text('You already have a request.'),
                            actions: <Widget>[
                              TextButton(
                                child:  const Text("OK"),
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
                } else if (await _bikeService
                        .findWithBikeCode(_bikeCodeController.text) ==
                    null) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Bike not found!'),
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
                } else if (await _bikeService
                        .isThisBikeTaken(_bikeCodeController.text) ==
                    null) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text('This bike is already taken!'),
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
                } else {
                  _bikeService.takeBike(
                      _bikeCodeController.text, _user!.email.toString());
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('Request successfull'),
                            content: const Text('Your request has been sent...'),
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
              child: const Text("Take a bike"),
            ),
          ],
        ),
      ),
    );
  }
}
