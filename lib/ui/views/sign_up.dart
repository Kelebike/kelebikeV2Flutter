import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelebikev2/ui/views/sign_in.dart';

import '../../core/constant/style.dart';
import '../../core/services/auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passswordAgainController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isChecked = false;
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Color.fromARGB(255, 29, 73, 167),
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color.fromARGB(255, 29, 73, 167),
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Color.fromARGB(255, 29, 73, 167),
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color.fromARGB(255, 29, 73, 167),
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordAgainTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passswordAgainController,
            obscureText: true,
            style: const TextStyle(
              color: Color.fromARGB(255, 29, 73, 167),
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color.fromARGB(255, 29, 73, 167),
              ),
              hintText: 'Enter your Password Again',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future navigateToSubPage(context) async {
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (isChecked) {
            if (_passwordController.text == _passswordAgainController.text &&
                _emailController.text.contains('@gtu.edu.tr') &&
                _passwordController.text.length >= 6) {
              _authService
                  .createPerson(_emailController.text, _passwordController.text)
                  .then((value) {
                if (value == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Welcome to Kelebike"),
                        content: const Text(
                            "Verify email has been sent your email. Please check it!"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              navigateToSubPage(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Account couln't be created"),
                    content: const Text(
                        "Requirements:\n\t\t\t-Mail address must have @gtu.edu.tr extension.\n\t\t\t-Password must be at least 6 characters."),
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
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Warning!"),
                  content:
                      const Text("You have accept the bike delivery terms."),
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
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: const Color.fromARGB(255, 29, 73, 167),
        ),
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBox() {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 60,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        checkColor: const Color(0xFF527DAA),
        activeColor: Colors.white,
        value: isChecked,
        onChanged: (isChecked) {
          setState(() {
            this.isChecked = isChecked!;
            if (isChecked == true) {
              String textFromFile;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.only(left: 25, right: 25),
                    title: const Center(child: Text("Bicycle Delivery Record")),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const <Widget>[
                            Text(
                                "I received the bike, which was given by the Department of Health and Sports Bicycle Unit and registered its brand, model and serial number, completely and intact."),
                            Text(
                              "Bicycle Delivery Terms",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "1- The temporary allocation period for bicycle use is 5 (five) working days. In case the usage period is extended, the registration renewal process will be done again. The person who does not do this will not be given a bike again. Bicycles will be delivered to the Bicycle Unit of the Department of Health, Culture and Sports."),
                            Text(
                                "2- The student/staff can only buy the bike in their own name. It is forbidden to buy a bicycle and make transactions on behalf of another person. Can only take one bike for own use"),
                            Text(
                                "3- The student/staff will deliver the received bike, complete with all its accessories, in good condition and in working condition, on the date of delivery."),
                            Text(
                                "4- Student/staff cannot lend, rent or sell the bicycle they have received to a third party."),
                            Text(
                                "5- The student/staff is responsible for the safety of the bicycle they receive. He is obliged to compensate for the value of the lost bike or to replace it with a new one of equal value."),
                            Text(
                                "6- Students/staff will use it in accordance with the Bicycle Usage Rules directive and Safe Cycling Guidelines in Cities.."),
                            Text(
                                "7- In cases where it is determined to be caused by user error, all expenses related to accidents and all kinds of material and moral damages, all kinds of malfunctions and repair expenses that may occur in bicycles due to use that are not in accordance with the driving rules and safety explanations and the rules in the Safe Cycling User's Guide in Cities are collected from the user. will be. Action is taken in accordance with the relevant legislation and directive.")
                          ],
                        ),
                      ),
                    ),
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
          });
        },
        title: const Text(
          'I have accept the bike delivery terms.',
          style:
              TextStyle(color: Color.fromARGB(255, 29, 73, 167), fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () => navigateToSubPage(context),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'You have already an account? ',
              style: TextStyle(
                color: Color.fromARGB(255, 29, 73, 167),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Color.fromARGB(255, 29, 73, 167),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                    color: Color.fromARGB(255, 201, 226, 101)),
              ),
              SizedBox(
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
                      const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 243, 91, 4),
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildEmailTF(),
                      const SizedBox(height: 10.0),
                      _buildPasswordTF(),
                      _buildPasswordAgainTF(),
                      const SizedBox(
                        height: 25.0,
                      ),
                      _buildCheckBox(),
                      _buildSignUpBtn(),
                      SizedBox(height: size.height * 0.15),
                      _buildLoginBtn(),
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
