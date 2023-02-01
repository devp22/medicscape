import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadNC extends StatefulWidget {
  final String conditionName;
  final String docID;
  const LoadNC({required this.conditionName, required this.docID}) : super();

  @override
  State<LoadNC> createState() => _LoadNCState();
}

class _LoadNCState extends State<LoadNC> {
  late String pdfName = "";
  late String pdf = "";
  late List<String> dos = [
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
  late List<String> donts = [
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
  late String conditonName = widget.conditionName;
  // late String cardName = widget.cardName;
  late String docID = widget.docID;
  Future<void> getData() async {
    print("IN GETDATA");
    var docSnapshot = await FirebaseFirestore.instance
        .collection(conditonName)
        .doc(docID)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      dos = List.from(data!["dos"]);
      overviews = List.from(data["overview"]);
      donts = List.from(data["donts"]);
      pdf = data["pdf"].toString();
      pdfName = data["pdfName"].toString();
    } else {
      print("DOES NOT EXISTs");
    }

    Navigator.pushNamed(context, '/nc', arguments: {
      "dos": dos,
      "donts": donts,
      "overviews": overviews,
      "cardName": docID,
      "pdf": pdf,
      "pdfName": pdfName,
      // "pdfName": documentID,
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
          SpinKitHourGlass(color: Colors.blueAccent)
        ]),
      ),
    );
  }
}
