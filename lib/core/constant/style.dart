import 'package:flutter/material.dart';

const kHintTextStyle = TextStyle(
  color: Color.fromARGB(136, 160, 157, 157),
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow:const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final bikeCodeDecorationStyle = BoxDecoration(
  color: const Color.fromARGB(255, 241, 103, 4),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow:const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
