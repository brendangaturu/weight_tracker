import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/record_weight.dart';
import 'package:weight_tracker/services/database.dart';
import 'package:intl/intl.dart';

class MyWeights extends StatelessWidget {
  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _databaseService.weights,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot);
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          // list of weight recorded from firestore
          var _weightRecords = snapshot.data;
          return _weightRecords.length > 0
              ? ListView.separated(
                  itemCount: _weightRecords.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecordWeight(
                                    title: 'Edit Weight',
                                    weightUnit: _weightRecords[index].unit,
                                    edit: true,
                                    uid: _weightRecords[index].uid))),
                        tileColor: Colors.white70,
                        title:
                            Text(_weightRecords[index].unit.toString() + ' Kg'),
                        trailing: Text(DateFormat.yMMMMd()
                            .add_jm()
                            .format(_weightRecords[index].updated)));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10.0);
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_forever_outlined,
                          size: 80.0, color: Colors.black12),
                      SizedBox(height: 20.0),
                      Text('You have no records',
                          style: TextStyle(color: Colors.black12))
                    ],
                  ),
                );
        });
  }
}
