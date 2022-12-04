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
<<<<<<< HEAD
                            height: size.height * .55,
=======
                            height: size.height ,
>>>>>>> parent of e94be32 (ui change)
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, index) {
<<<<<<< HEAD
                                return Row(
=======
                                return Column(
>>>>>>> parent of e94be32 (ui change)
                                  children: [
                                    FutureBuilder<int>(
                                      future: _bikeService.totalBike(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return MyHorizontalList(
<<<<<<< HEAD
                                            height: 349,
                                            width: 246,
                                            startColor: Colors.orange.shade100,
                                            endColor: const Color.fromARGB(
                                                255, 241, 199, 33),
                                            courseHeadline: 'Toplam',
                                            courseTitle:
                                                'TOPLAM \nBISIKLET\nSAYISI : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/total.png',
                                            scale: 14,
=======
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
>>>>>>> parent of e94be32 (ui change)
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
<<<<<<< HEAD
                                            height: 349,
                                            width: 246,
                                            startColor: Colors.orange.shade100,
=======
                                            height: 100,
                                            width: size.width*0.9,
                                            startColor: Color.fromARGB(255, 205, 248, 241),
>>>>>>> parent of e94be32 (ui change)
                                            endColor: const Color.fromARGB(
                                                255, 54, 235, 244),
                                            courseHeadline: 'Uygun Bisiklet',
                                            courseTitle:
<<<<<<< HEAD
                                                'TOPLAM \nBISIKLET\nSAYISI : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/available.png',
                                            scale: 1.8,
=======
                                                'Uygun Bisiklet Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/available.png',
                                            scale: 4,
>>>>>>> parent of e94be32 (ui change)
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
<<<<<<< HEAD
                                            height: 349,
                                            width: 246,
=======
                                            height: 100,
                                            width: size.width*0.9,
>>>>>>> parent of e94be32 (ui change)
                                            startColor: const Color.fromARGB(
                                                255, 215, 212, 207),
                                            endColor:
                                                const Color.fromARGB(255, 70, 81, 87),
                                            courseHeadline: 'Tamir',
                                            courseTitle:
<<<<<<< HEAD
                                                'TOPLAM TAMİRDEKİ \nBİSİKLET\nSAYISI : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/repair.png',
                                            scale: 8,
=======
                                                'Tamirdeki Bisiklet Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/repair.png',
                                            scale: 30,
>>>>>>> parent of e94be32 (ui change)
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
<<<<<<< HEAD
                                            height: 349,
                                            width: 246,
=======
                                            height: 100,
                                            width: size.width*0.9,
>>>>>>> parent of e94be32 (ui change)
                                            startColor: const Color.fromARGB(
                                                255, 225, 246, 133),
                                            endColor: const Color.fromARGB(
                                                255, 0, 183, 110),
                                            courseHeadline: 'Dolaşım',
                                            courseTitle:
<<<<<<< HEAD
                                                'TOPLAM DOLAŞIMDAKİ \nBİSİKLET\nSAYISI : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/circulation.png',
                                            scale: 16,
=======
                                                'Dolaşımdaki Bisiklet Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/circulation.png',
                                            scale: 55,
>>>>>>> parent of e94be32 (ui change)
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
<<<<<<< HEAD
                                            height: 349,
                                            width: 246,
=======
                                            height: 100,
                                            width: size.width*0.9,
>>>>>>> parent of e94be32 (ui change)
                                            startColor: const Color.fromARGB(
                                                255, 191, 208, 172),
                                            endColor: const Color.fromARGB(
                                                255, 125, 158, 214),
                                            courseHeadline: 'Alım İsteği',
                                            courseTitle:
<<<<<<< HEAD
                                                'TOPLAM \nALIM İSTEĞİ\nSAYISI : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/take.png',
                                            scale: 9,
=======
                                                'Alım İsteği Sayısı : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/take.png',
                                            scale: 30,
>>>>>>> parent of e94be32 (ui change)
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
<<<<<<< HEAD
                                            height: 349,
                                            width: 246,
=======
                                            height: 100,
                                            width: size.width*0.9,
>>>>>>> parent of e94be32 (ui change)
                                            startColor: const Color.fromARGB(
                                                255, 240, 216, 232),
                                            endColor: const Color.fromARGB(
                                                255, 196, 12, 147),
                                            courseHeadline: 'İade İsteği',
                                            courseTitle:
<<<<<<< HEAD
                                                'TOPLAM \nİADE İSTEĞİ\nSAYISI : ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/return.png',
                                            scale: 8,
=======
                                                'İade İsteği Sayısı: ' +
                                                    '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/return.png',
                                            scale: 30,
>>>>>>> parent of e94be32 (ui change)
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
<<<<<<< HEAD
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  'assets/logos/admin.png',
                  height: size.height * .3,
                  width: size.width,
                ),
              )
=======
>>>>>>> parent of e94be32 (ui change)
            ],
          );
        });
  }
}
