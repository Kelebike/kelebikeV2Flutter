import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constant/style.dart';
import '../../core/services/bike_service.dart';
import '../../core/services/history_service.dart';
import 'home_screen.dart';

class Return extends StatefulWidget {
  @override
  _ReturnState createState() => _ReturnState();
}

TextEditingController _bikeCodeController = TextEditingController();
Widget _buildBikeCode() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10.0),
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

class _ReturnState extends State<Return> {
  final BikeService _bikeService = BikeService();
  final HistoryService _historyService = HistoryService();
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF6CA8F1),
        elevation: 0,
        title: const Text("Give back bike"),
        centerTitle: true,
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
                      MaterialStateProperty.all(const Color(0xFF6CA8F1)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 15))),
              onPressed: () async {
                await _historyService
                    .getBikeWithCode(_bikeCodeController.text);
                String? docID = await _bikeService
                    .findWithBikeCode(_bikeCodeController.text);

                if (await _bikeService
                        .findWithReturn(_user!.email.toString()) ==
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
                                          builder: (context) =>
                                              HomeScreen()));
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
                } else if (docID == null) {
                  showDialog(
                      context: context,
                      builder: (_) => const AlertDialog(
                            title: Text('Error'),
                            content: Text('Bike not found!'),
                          ));
                } else {
                  await _bikeService.returnBike(_bikeCodeController.text);
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('Request Succesfull'),
                            content:
                                const Text('Your return request has been sent...'),
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
              child: const Text("Give back the bike"),
            )
          ],
        ),
      ),
    );
  }
}
