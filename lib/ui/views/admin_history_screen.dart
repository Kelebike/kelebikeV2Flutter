import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/services/history_service.dart';

List<List<String>> itemList = [];

class AdminHistoryScreen extends StatefulWidget {
  @override
  _AdminHistoryScreenState createState() => _AdminHistoryScreenState();
}

class _AdminHistoryScreenState extends State<AdminHistoryScreen> {
  final HistoryService _historyService = HistoryService();
  Color isTaken(String taken) {
    if (taken == "taken") {
      return Colors.red;
    } else if (taken == "waiting") {
      return Colors.yellow;
    } else if (taken == "nontaken") {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  }

  List parse(String bike) {
    String s = bike;
    var parts = s.split(',');
    parts[0] = parts[0]
        .toString()
        .substring(7, parts[0].toString().length); //account 0
    parts[1] =
        parts[1].toString().substring(6, parts[1].toString().length); //code 1
    parts[3] =
        parts[3].toString().substring(8, parts[3].toString().length); //issued 3
    parts[5] =
        parts[5].toString().substring(8, parts[5].toString().length); //return 5

    return parts;
  }

  @override
  void initState() {
    super.initState();
    itemList = [
      <String>["ID", "Bike Code", "Account", "Issued", "Return"]
    ];
  }

  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () {
          //generateCSV();
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _historyService.getHistory(),
        builder: (context, snaphot) {
          return !snaphot.hasData
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snaphot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snaphot.data!.docs[index];
                    String _bike = "${mypost['bike']}";
                    var infoBike = parse(_bike);
                    itemList.add(<String>[
                      mypost.id,
                      infoBike[1],
                      infoBike[0],
                      infoBike[3],
                      infoBike[5]
                    ]);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: size.height * .2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xFF6CA8F1), width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Bike: "),
                                Text(infoBike[0]),
                                Text(infoBike[1]),
                                Text(infoBike[2]),
                                Text(infoBike[3]),
                                Text(infoBike[4]),
                                Text(infoBike[5]),
                                Text(infoBike[6]),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
