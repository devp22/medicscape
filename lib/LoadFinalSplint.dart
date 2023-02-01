import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadFinalSplint extends StatefulWidget {
  late String documentID = "";
  late String cardName = "";
  late String title = "";

  LoadFinalSplint(
      {required this.cardName, required this.documentID, required this.title})
      : super();

  @override
  State<LoadFinalSplint> createState() => _LoadFinalSplintState();
}

class _LoadFinalSplintState extends State<LoadFinalSplint> {
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
    } else {
      print("DOES NOT EXISTs");
    }

    Navigator.pushNamed(context, '/readsplint', arguments: {
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
          SpinKitHourGlass(color: Color(0xFF005CA0))
        ]),
      ),
    );
  }
}
