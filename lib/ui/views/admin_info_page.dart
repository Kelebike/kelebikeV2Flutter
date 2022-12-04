import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/services/bike_service.dart';
import '../widgets/my_horizontal_list.dart';

class AdminInfoPage extends StatefulWidget {
  @override
  _AdminInfoPageState createState() => _AdminInfoPageState();
}

class _AdminInfoPageState extends State<AdminInfoPage> {
  final BikeService _bikeService = BikeService();
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: _bikeService.getBike(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          if (snapshot.connectionState == ConnectionState.done) {}
          return Column(
            children: [
              Expanded(
                child: Container(
                  height: size.height * 0.55,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mypost = snapshot.data!.docs[index];

                          return SizedBox(
                            height: size.height ,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    FutureBuilder<int>(
                                      future: _bikeService.totalBike(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return MyHorizontalList(
                                            height: 100,
                                            width: size.width*0.9,
                                            startColor: Colors.orange.shade100,
                                            endColor: Color.fromARGB(255, 241, 113, 33),
                                            courseHeadline: 'Toplam',
                                            courseTitle:
                                                'Toplam Bisiklet Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/total.png',
                                            scale: 50,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    FutureBuilder<int>(
                                      future: _bikeService
                                          .findWithStatus("nontaken"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return MyHorizontalList(
                                            height: 100,
                                            width: size.width*0.9,
                                            startColor: Color.fromARGB(255, 205, 248, 241),
                                            endColor: const Color.fromARGB(
                                                255, 54, 235, 244),
                                            courseHeadline: 'Uygun Bisiklet',
                                            courseTitle:
                                                'Uygun Bisiklet Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/available.png',
                                            scale: 4,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    FutureBuilder<int>(
                                      future:
                                          _bikeService.findWithStatus("repair"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return MyHorizontalList(
                                            height: 100,
                                            width: size.width*0.9,
                                            startColor: const Color.fromARGB(
                                                255, 215, 212, 207),
                                            endColor:
                                                const Color.fromARGB(255, 70, 81, 87),
                                            courseHeadline: 'Tamir',
                                            courseTitle:
                                                'Tamirdeki Bisiklet Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/repair.png',
                                            scale: 30,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    FutureBuilder<int>(
                                      future:
                                          _bikeService.findWithStatus("taken"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return MyHorizontalList(
                                            height: 100,
                                            width: size.width*0.9,
                                            startColor: const Color.fromARGB(
                                                255, 225, 246, 133),
                                            endColor: const Color.fromARGB(
                                                255, 0, 183, 110),
                                            courseHeadline: 'Dolaşım',
                                            courseTitle:
                                                'Dolaşımdaki Bisiklet Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/circulation.png',
                                            scale: 55,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    FutureBuilder<int>(
                                      future: _bikeService
                                          .findWithStatus("waiting"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return MyHorizontalList(
                                            height: 100,
                                            width: size.width*0.9,
                                            startColor: const Color.fromARGB(
                                                255, 191, 208, 172),
                                            endColor: const Color.fromARGB(
                                                255, 125, 158, 214),
                                            courseHeadline: 'Alım İsteği',
                                            courseTitle:
                                                'Alım İsteği Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/take.png',
                                            scale: 30,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    FutureBuilder<int>(
                                      future: _bikeService
                                          .findWithStatus("returned"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return MyHorizontalList(
                                            height: 100,
                                            width: size.width*0.9,
                                            startColor: const Color.fromARGB(
                                                255, 240, 216, 232),
                                            endColor: const Color.fromARGB(
                                                255, 196, 12, 147),
                                            courseHeadline: 'İade İsteği',
                                            courseTitle:
                                                'İade İsteği Sayısı: ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/return.png',
                                            scale: 30,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
