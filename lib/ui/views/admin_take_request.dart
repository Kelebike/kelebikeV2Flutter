import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constant/style.dart';
import '../../core/services/bike_service.dart';

class TakeRequest extends StatefulWidget {
  @override
  _TakeRequestState createState() => _TakeRequestState();
}

class _TakeRequestState extends State<TakeRequest> {
  final _LockController = TextEditingController();

  final BikeService _bikeService = BikeService();
  DateTime selectedDate = DateTime.now();
  DateTime nowDate = DateTime.now();

  Widget _buildSetLock(String docID) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
        _bikeService.confirmTakingBike(docID, nowDate.toString(),
            selectedDate.toString(), _LockController.text);
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
          _selectDate(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          'Lock Bike',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

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

                  Future<void> _selectLock(BuildContext context) async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                                height: 190,
                                child: Column(
                                  children: [
                                    _buildLock(),
                                    _buildSetLock(mypost.id),
                                  ],
                                )),
                          );
                        });
                  }

                  if ("${mypost['status']}" == "waiting") {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          await _selectLock(context);
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
