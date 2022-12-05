import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelebikev2/ui/views/sign_in.dart';
import 'package:kelebikev2/ui/views/take_bike_page.dart';

import '../../core/services/bike_service.dart';
import '../../core/services/blacklist_service.dart';
import '../../core/services/localization_service.dart';
import '../widgets/my_horizontal_list.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final localizationController = Get.find<LocalizationController>();
  final BikeService _bikeService = BikeService();

  bool available(String nm) {
    if (nm != "0") {
      return true;
    } else {
      return false;
    }
  }

  Widget takeBikeUserInfo() {
    var size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * 0.65,
        width: size.width * 0.9,
        child: Column(children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset("assets/logos/man_bike.jpg"),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "There is no bike here. Let's fly like kelebike!\n",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          _buildTakeBtn(),
        ]),
      ),
    );
  }

  Widget expiredUser(String bikeCode) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * 0.65,
        width: size.width * 0.9,
        child: Column(children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset("assets/logos/workshop.jpg"),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Your rental time is up!",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 15,
            ),
          ),
          Text(
            "Please leave the bike at the workshop.\n",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: size.height * 0.15,
          ),
          _buildReturnBtn(bikeCode),
        ]),
      ),
    );
  }

  Widget waitingForConfirmation() {
    return Center(
      child: SizedBox(
        height: 200.0,
        width: 300.0,
        child: Column(children: [
          Text(
            "Waiting for confirmation!\n",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
            ),
          ),
          const CircularProgressIndicator()
        ]),
      ),
    );
  }

  Widget _buildTakeBtn() {
    User? _user = FirebaseAuth.instance.currentUser;
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
      width: size.width * 0.65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF6CA8F1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5.0,
          ),
          onPressed: () async {
            var _blackListService = BlacklistService();
            String? isInBlack =
                await _blackListService.findWithEmail(_user!.email.toString());
            if (isInBlack == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TakeBikePage())); //TakeBikePage
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Opps!"),
                    content: const Text(
                        "You're in blacklist now. You can't take a bike..."),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            children: const [
              Icon(Icons.bike_scooter),
              Text(
                " Let's take a bike!",
              ),
            ],
          )),
    );
  }

  Widget _buildReturnBtn(String bikeCode) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6CA8F1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5.0,
          ),
          onPressed: () {
            Future<void> _showChoiseDialog(BuildContext context) {
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text(
                          "Bisikleti teslim etmek istediğinize emin misiniz?",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    await _bikeService.returnBike(bikeCode);
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
                              ],
                            )));
                  });
            }

            ;
            _showChoiseDialog(context);
          },
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back),
              Text(
                LocalizationService.of(context).translate('gv_bck_bike')!,
              ),
            ],
          )),
    );
  }

  Widget bikeAvailable() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: _bikeService.getBike(),
      builder: (context, snaphot) {
        int flag = 0;
        return !snaphot.hasData
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Container(
                    color: Colors.green.shade200,
                    height: size.height * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            DocumentSnapshot mypost = snaphot.data!.docs[index];

                            return SizedBox(
                              height: size.height * .25,
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: FutureBuilder<int>(
                                      future: _bikeService
                                          .findWithStatus("nontaken"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.hasData) {
                                          return MyHorizontalList(
                                            height: size.height * 0.18,
                                            width: size.width * 0.9,
                                            startColor: const Color.fromARGB(
                                                255, 193, 218, 241),
                                            endColor: const Color.fromARGB(
                                                255, 24, 106, 228),
                                            courseHeadline: "Total",
                                            courseTitle: "Available Bike:  " +
                                                '${snapshot.data}',
                                            courseImage:
                                                'assets/logos/myavailbike.png',
                                            scale: 15,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String bikeCode = "";
    User? _user = FirebaseAuth.instance.currentUser;
    var size = MediaQuery.of(context).size;
    var taken_counter = 0;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return StreamBuilder(
        stream: _bikeService.getBike(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          if (snapshot.connectionState == ConnectionState.done) {}
          return FutureBuilder<int>(
            future: _bikeService.findWithUserInfo(_user!.email.toString()),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                if (available('${snapshot.data}')) {
                  return Scaffold(
                      backgroundColor: const Color(0xFF6CA8F1).withOpacity(0.4),
                      body: Column(
                        children: [
                          bikeAvailable(),
                          Stack(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: _bikeService.getBike(),
                                builder: (context, snaphot) {
                                  return !snaphot.hasData
                                      ? const CircularProgressIndicator()
                                      : Column(
                                          children: [
                                            Container(
                                              height: size.height * 0.75 - 60,
                                              color: Colors.green.shade200,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: ListView.builder(
                                                    itemCount: snaphot
                                                        .data!.docs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      DocumentSnapshot mypost =
                                                          snaphot.data!
                                                              .docs[index];
                                                      if ("${mypost['owner']}" ==
                                                              _user.email
                                                                  .toString() &&
                                                          "${mypost['status']}" ==
                                                              "taken") {
                                                        bikeCode =
                                                            '${mypost['code']}';
                                                        return SizedBox(
                                                          //todo!
                                                          height: size.height *
                                                              0.60,
                                                          child:
                                                              ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            itemCount: 1,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                children: [
                                                                  MyHorizontalList(
                                                                    height: 200,
                                                                    width:
                                                                        size.width *
                                                                            0.9,
                                                                    startColor:
                                                                        const Color.fromARGB(
                                                                            255,
                                                                            237,
                                                                            187,
                                                                            112),
                                                                    endColor:
                                                                        const Color.fromARGB(
                                                                            255,
                                                                            245,
                                                                            180,
                                                                            30),
                                                                    courseHeadline: LocalizationService.of(
                                                                            context)
                                                                        .translate(
                                                                            'my_bike')!,
                                                                    courseTitle: '${LocalizationService.of(context).translate(
                                                                            'bike_code_c_n')!}${mypost['code']}\n${LocalizationService.of(context)
                                                                            .translate('lock')!}${mypost['lock']}',
                                                                    courseImage:
                                                                        'assets/logos/bike_woman.png',
                                                                    scale: 1.7,
                                                                  ),
                                                                  Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    children: [
                                                                      MyHorizontalList(
                                                                        height:
                                                                            200,
                                                                        width: size.width *
                                                                            .9,
                                                                        startColor: const Color.fromARGB(
                                                                            255,
                                                                            233,
                                                                            187,
                                                                            187),
                                                                        endColor: const Color.fromARGB(
                                                                            255,
                                                                            252,
                                                                            95,
                                                                            229),
                                                                        courseHeadline:
                                                                            LocalizationService.of(context).translate('rmn_time_n')!,
                                                                        courseTitle: LocalizationService.of(context).translate('issued')! +
                                                                            '${mypost['issued']}'.substring(0,
                                                                                11) +
                                                                            LocalizationService.of(context).translate(
                                                                                'n_rtrn_n')! +
                                                                            '${mypost['return']}'.substring(0,
                                                                                11),
                                                                        courseImage:
                                                                            'assets/logos/countdown.png',
                                                                        scale:
                                                                            2.2,
                                                                      ),
                                                                      CountdownTimer(
                                                                        endTime:
                                                                            DateTime.parse("${mypost['return']}").millisecondsSinceEpoch,
                                                                        widgetBuilder: (_,
                                                                            CurrentRemainingTime?
                                                                                time) {
                                                                          if (time ==
                                                                              null) {
                                                                            return Text(
                                                                              '\n\n\n\n\n\n\n     Time Expired!',
                                                                              style: GoogleFonts.roboto(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: const Color.fromARGB(255, 115, 115, 115),
                                                                                fontSize: 20,
                                                                              ),
                                                                            );
                                                                            ; //time expired
                                                                          }
                                                                          String
                                                                              days =
                                                                              '${time.days}';

                                                                          String
                                                                              hours =
                                                                              '${time.hours}';

                                                                          String
                                                                              mins =
                                                                              '${time.min}';
                                                                          String
                                                                              secs =
                                                                              '${time.sec}';
                                                                          if (time.days ==
                                                                              null) {
                                                                            days =
                                                                                "";
                                                                          }
                                                                          if (time.hours ==
                                                                              null) {
                                                                            hours =
                                                                                "";
                                                                          }
                                                                          if (time.min ==
                                                                              null) {
                                                                            mins =
                                                                                "";
                                                                          }
                                                                          if (time.sec ==
                                                                              null) {
                                                                            secs =
                                                                                "";
                                                                          }

                                                                          return Text(
                                                                            '\n\n\n\n\n\n\n      ${days.padLeft(2, '0')} : ${hours.padLeft(2, '0')} : ${mins.padLeft(2, '0')} : ${secs.padLeft(2, '0')}',
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: const Color.fromARGB(255, 115, 115, 115),
                                                                              fontSize: 20,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  _buildReturnBtn(
                                                                      bikeCode),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      } else if (("${mypost['owner']}" ==
                                                                  _user.email
                                                                      .toString() &&
                                                              "${mypost['status']}" ==
                                                                  "waiting") ||
                                                          ("${mypost['owner']}" ==
                                                                  _user.email
                                                                      .toString() &&
                                                              "${mypost['status']}" ==
                                                                  "returned")) {
                                                        return waitingForConfirmation();
                                                      } else if ("${mypost['owner']}" ==
                                                              _user.email
                                                                  .toString() &&
                                                          "${mypost['status']}" ==
                                                              "expired") {
                                                        return expiredUser(
                                                            "${mypost['code']}");
                                                      } else {
                                                        return const SizedBox
                                                            .shrink();
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        ],
                      ));
                } else {
                  return Scaffold(
                      backgroundColor: Colors.green.shade200,
                      body: Column(
                        children: [
                          bikeAvailable(),
                          takeBikeUserInfo(),
                        ],
                      ));
                }
              } else {
                return const Text('Loading...');
              }
            },
          );
        });
  }
}
