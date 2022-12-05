import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../../core/constant/style.dart';
import '../../core/services/bike_service.dart';
import 'admin_screen.dart';

class adminAddBikePage extends StatefulWidget {
  @override
  _adminAddBikePageState createState() => _adminAddBikePageState();
}

class _adminAddBikePageState extends State<adminAddBikePage> {
  final _BrandController = TextEditingController();
  final _CodeController = TextEditingController();

  final BikeService _bikeService = BikeService();
  final User? _user = FirebaseAuth.instance.currentUser;

  Widget _Brand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Marka:',
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
            controller: _BrandController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.blue,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.bike_scooter,
                color: Colors.blue,
              ),
              hintText: 'Marka',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget _Code() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Kod:',
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
            controller: _CodeController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              color: Colors.blue,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.qr_code,
                color: Colors.blue,
              ),
              hintText: 'Kod',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAddBike() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          _bikeService.addBike(
            lock: 'nontaken',
            brand: _BrandController.text,
            code: _CodeController.text,
            status: 'nontaken',
            owner: 'nontaken',
            dateIssued: "nontaken",
            dateReturn: "nontaken",
          );
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminScreen()));
        },
        child: const Text(
          'Bisiklet Ekle',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6CA8F1),
        elevation: 0,
        title: const Text("Bisiklet Ekle"),
        centerTitle: true,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6CA8F1),
                  )),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _Brand(),
                      const SizedBox(
                        height: 10,
                      ),
                      _Code(),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildAddBike()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
