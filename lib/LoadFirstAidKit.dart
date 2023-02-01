import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadFirstAidKit extends StatefulWidget {
  late String title;
  LoadFirstAidKit({required this.title}) : super();

  @override
  State<LoadFirstAidKit> createState() => _LoadFirstAidKitState();
}

class _LoadFirstAidKitState extends State<LoadFirstAidKit> {
  late String title = widget.title;
  late String documentID = "FirstAidKit";
  late String cardName = "FirstAidKit";
  List<String> points = [];
  Future<void> getData() async {
    print("IN GETDATA");
    var docSnapshot = await FirebaseFirestore.instance
        .collection(cardName)
        .doc(documentID)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      points = List.from(data!["Points"]);
    } else {
      print("DOES NOT EXISTs");
    }

    Navigator.pushNamed(context, '/readfirstaidkit', arguments: {
      "points": points,
      "documentID": documentID,
      "title": title,
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
          ),
          SpinKitHourGlass(
            color: Color(0xFF005CA0),
          )
        ]),
      ),
    );
  }
}
