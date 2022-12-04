import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constant/style.dart';
import '../../core/services/bike_service.dart';
import '../../core/services/blacklist_service.dart';
import '../../core/services/history_service.dart';

class ReturnRequest extends StatefulWidget {
  @override
  _ReturnRequestState createState() => _ReturnRequestState();
}

class _ReturnRequestState extends State<ReturnRequest> {
  final HistoryService _historyService = HistoryService();
  final _blackListService = BlacklistService();
  final BikeService _bikeService = BikeService();
  final _reasonController = TextEditingController();
  final User? _user = FirebaseAuth.instance.currentUser;

  Future<void> _buildBlackList(BuildContext context, String user) async {
    print(user);
    Widget _buildReason() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Açıklama:',
            style: kLabelStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(12),
            height: 5 * 24.0,
            child: TextField(
              controller: _reasonController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Açıklama Girin...",
                fillColor: Colors.grey[300],
                filled: true,
              ),
            ),
          ),
        ],
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            content: SizedBox(
                height: 305,
                child: Column(
                  children: [
                    _buildReason(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _blackListService.addBlackList(
                              user: user, reason: _reasonController.text);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Karalisteye Ekle',
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _bikeService.getBike(),
      builder: (context, snaphot) {
        return !snaphot.hasData
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: snaphot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snaphot.data!.docs[index];
                  Future<void> _showChoiseDialog(BuildContext context) {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text(
                                "Bisikleti teslim almak istediğinize emin misiniz?",
                                textAlign: TextAlign.center,
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              content: Container(
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          print('${mypost['code']}');
                                          await _historyService
                                              .addHistory('${mypost['code']}');
                                          await _bikeService.confirmReturnBike(
                                              '${mypost['code']}');

                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Evet",
                                          style: TextStyle(
                                              color: Color(0xFF6CA8F1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Vazgeç",
                                          style: TextStyle(
                                              color: Color(0xFF6CA8F1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          _buildBlackList(
                                              context, '${mypost['owner']}');
                                        },
                                        child: const Text(
                                          "Kara Listeye Al",
                                          style: TextStyle(
                                              color: Color(0xFF6CA8F1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )));
                        });
                  }

                  if ("${mypost['status']}" == "returned") {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _showChoiseDialog(context);
                        },
                        child: Container(
                          height: size.height * .3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xFF6CA8F1), width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Kod: "),
                                      Text(
                                        "${mypost['code']} ",
                                        style: const TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(" Marka: "),
                                      Text("${mypost['brand']}"),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("   Hesap: "),
                                      Text("${mypost['owner']}"),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("   Alım: "),
                                      Text("${mypost['issued']}"
                                          .substring(0, 11)),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("   Teslim: "),
                                      Text("${mypost['return']}"
                                          .substring(0, 11)),
                                    ]),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Text("");
                  }
                });
      },
    );
  }
}
