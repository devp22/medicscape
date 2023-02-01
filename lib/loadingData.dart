import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingData extends StatefulWidget {
  final String collectionName;
  final String documentName;
  LoadingData({required this.collectionName, required this.documentName})
      : super();

  @override
  State<LoadingData> createState() => _LoadingDataState();
}

class _LoadingDataState extends State<LoadingData> {
  late String pdf =
      "https://firebasestorage.googleapis.com/v0/b/medicscape-5eaf5.appspot.com/o/Fever.pdf?alt=media&token=5a73cfc8-d682-4c99-9ebd-87c7d7c93511";
  late String pdfName = "";
  late String video = "";
  late List<String> symptoms = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  late List<String> overviews = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  late List<String> remedies = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  late List<String> causes = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  late String collectionName = widget.collectionName;
  late String documentName = widget.documentName;
  late String name = "";
  // late var numberOfSymptoms;
  // late var numberOfRemedies;
  // late var numberOfOverviews;
  // late var numberOfCauses;
  late String temp = "jbihbh";
  Future<void> getData() async {
    print("IN GETDATA");
    var docSnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      symptoms = List.from(data!["Symptoms"]);
      overviews = List.from(data["Overview"]);
      remedies = List.from(data["Remedies"]);
      causes = List.from(data["Causes"]);
      video = data["video"].toString();
      pdf = data["pdf"].toString();
      name = data["name"].toString();
      pdfName = data["pdfName"].toString();
      // print(pdf);
    } else {
      print("DOES NOT EXISTs");
    }
    print("PDF: " + pdf);
    Navigator.pushNamed(context, '/info', arguments: {
      "symptoms": symptoms,
      "remedies": remedies,
      "overviews": overviews,
      "causes": causes,
      "pdf": pdf,
      "pdfName": pdfName,
      "name": name,
      "video": video,
      // "numberOfSymptoms": ns,
      // "numberOfRemedies": nr,
      // "numberOfOverviews": no,
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
