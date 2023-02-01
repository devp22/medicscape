// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Sample3 extends StatefulWidget {
  final String collectionName;
  final String documentName;
  Sample3({required this.collectionName, required this.documentName}) : super();

  @override
  State<Sample3> createState() => _Sample3State();
}

class _Sample3State extends State<Sample3> {
  late String pdf =
      "https://firebasestorage.googleapis.com/v0/b/medicscape-5eaf5.appspot.com/o/Fever.pdf?alt=media&token=5a73cfc8-d682-4c99-9ebd-87c7d7c93511";
  late String pdfName = "";
  late String video = "";
  late List<String> dos = [];
  late List<String> donts = [];
  late List<String> overview = [];
  late List<String> gujDos = [];
  late List<String> gujDonts = [];
  late List<String> gujOverview = [];
  late String collectionName = widget.collectionName;
  late String documentName = widget.documentName;
  late String name = "";
  Future<void> getData() async {
    print("IN GETDATA");
    var docSnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      dos = List.from(data!["dos"]);
      donts = List.from(data["donts"]);
      overview = List.from(data["overview"]);
      // gujDos = List.from(data["gujDos"]);
      // gujDonts = List.from(data["gujDonts"]);
      // gujOverview = List.from(data["gujOverview"]);
      pdf = data["pdf"];
      pdfName = data["pdfName"];
      name = data["name"];
    } else {
      print("DOES NOT EXISTs");
    }
    print("VIDEO: " + video);
    Navigator.pushNamed(context, '/translate1', arguments: {
      "dos": dos,
      "donts": donts,
      "overviews": overview,
      // "gujDos": gujDos,
      // "gujDonts": gujDonts,
      // "gujOverview": gujOverview,
      "pdf": pdf,
      "pdfName": pdfName,
      "name": name,
      "condition": documentName,
    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() => getData());
  }

  @override
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
