import 'package:flutter/material.dart';
import 'package:weight_tracker/services/database.dart';


class RecordWeight extends StatefulWidget {
  final String title;
  final double weightUnit;
  final bool edit; 
  final String uid; 

  const RecordWeight(
      {Key key, this.title, this.weightUnit, this.edit, this.uid})
      : super(key: key);
  @override
  _RecordWeightState createState() => _RecordWeightState();
}

class _RecordWeightState extends State<RecordWeight> {
  final _formKey = GlobalKey<FormState>();
  final _databaseService = DatabaseService();
  double _weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        widget.edit
            ? IconButton(
                onPressed: () async => await _databaseService
                    .deleteWeight(uid: widget.uid)
                    .whenComplete(() => Navigator.pop(context)),
                icon: Icon(Icons.delete),
              )
            : Container()
      ]),
      body: Center(
        child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      initialValue:
                          widget.edit ? widget.weightUnit.toString() : null,
                      keyboardType: TextInputType.number,
                      validator: (val) => val.length == 0
                          ? 'Please Enter the weight in kg'
                          : '',
                      onChanged: (val) {
                        setState(() {
                          _weight = double.parse(val);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Weight in Kg',
                        // border:
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    width: MediaQuery.of(context).size.height,
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                        !widget.edit
                            ? await _databaseService
                                .uploadWeight(
                                    unit: _weight, updated: DateTime.now())
                                .whenComplete(() => Navigator.pop(context))
                            : await _databaseService
                                .editWeight(unit: _weight, uid: widget.uid)
                                .whenComplete(() => Navigator.pop(context));
                        }
                      },
                      child: Text('Save'),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(),
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
