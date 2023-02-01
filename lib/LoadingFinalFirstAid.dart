import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadFinalFirstAid extends StatefulWidget {
  late String documentID = "";
  late String cardName = "";
  late String title = "";
  LoadFinalFirstAid(
      {required this.cardName, required this.documentID, required this.title})
      : super();

  @override
  State<LoadFinalFirstAid> createState() => _LoadFinalFirstAidState();
}

class _LoadFinalFirstAidState extends State<LoadFinalFirstAid> {
  late List<String> points = [];
  late String documentID = "";
  late String cardName = "";
  late String title = "";
  Future<void> getData() async {
    // Map information = ModalRoute.of(context)?.settings.arguments as Map;
    documentID = widget.documentID;
    cardName = widget.cardName;
    title = widget.title;
    print("IN GETDATA");
    var docSnapshot = await FirebaseFirestore.instance
        .collection(cardName)
        .doc(documentID)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      points = List.from(data!["points"]);
      print("DOES NOT EXISTs");
    }

    Navigator.pushNamed(context, '/readfirstaid', arguments: {
      "points": points,
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
          SpinKitHourGlass(color: Colors.blueAccent)
        ]),
      ),
    );
  }
}
