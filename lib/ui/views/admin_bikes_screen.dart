import 'package:flutter/material.dart';
import 'admin_add_bike_page.dart';
import 'bikepage.dart';

class AdminBikesScreen extends StatefulWidget {
  @override
  _AdminBikesScreenState createState() => _AdminBikesScreenState();
}

class _AdminBikesScreenState extends State<AdminBikesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6CA8F1),
        elevation: 0,
        title: const Text("Tüm Bisikletler"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 243, 92, 4),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => adminAddBikePage()));
        },
        child: const Icon(Icons.add),
      ),
      body: BikePage(),
    );
  }
}
