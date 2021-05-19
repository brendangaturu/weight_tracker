import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/my_weights.dart';
import 'package:weight_tracker/screens/record_weight.dart';
import 'package:weight_tracker/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weight Tracker')),
      body: MyWeights(),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person_outline_outlined, color: Colors.black),
              ),
              accountEmail: Text(''),
              accountName: Text('Anonymous'),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              onTap: () async => await _auth.signOut(),
              leading: Icon(Icons.logout),
              title: Text('SignOut'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RecordWeight(title: 'Record Your Weight', edit: false))),
          label: Text('Weight'),
          icon: Icon(Icons.add)),
    );
  }
}
