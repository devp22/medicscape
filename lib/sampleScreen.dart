import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SampleScreen extends StatefulWidget {
  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  List<String> images = [];
  List<String> documentID = [];
  // List<String> phone = [];

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("NaturalCalamities")
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        for (int i = 0; i < value.docs.length; i++) {
          images.add(value.docs[i].data()["image"].toString());
          documentID.add(value.docs[i].data()["documentID"].toString());
        }
        print("GOT DATA");
      } else {
        print("Not Found");
      }
    });
    print("SENDING DATA");
    Navigator.pushNamed(context, '/sample2', arguments: {
      "images": images,
      "documentID": documentID,
      "collectionName": "NaturalCalamities",
    });
  }

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() => getData());
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            SpinKitHourGlass(
              color: Color(0xFF005CA0),
            ),
          ],
        ),
      ),
    );
  }
}
