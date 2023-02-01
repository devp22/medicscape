import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadNC1 extends StatefulWidget {
  late String cardName;

  LoadNC1({required this.cardName}) : super();

  @override
  State<LoadNC1> createState() => _LoadNC1State();
}

class _LoadNC1State extends State<LoadNC1> {
  late String cardName = widget.cardName;
  List<String> images = [];
  List<String> name = [];
  List<String> docID = [];
  Future<void> getData() async {
    await FirebaseFirestore.instance.collection(cardName).get().then((value) {
      if (value.docs.length > 0) {
        for (int i = 0; i < value.docs.length; i++) {
          images.add(value.docs[i].data()["image"].toString());
          name.add(value.docs[i].data()["name"].toString());
          docID.add(value.docs[i].data()["documentID"].toString());
        }
        print("GOT DATA");
      } else {
        print("Not Found");
      }
    });
    print("SENDING DATA");
    Navigator.pushNamed(context, '/commonnc', arguments: {
      "images": images,
      "name": name,
      "collectionName": cardName,
      "docID": docID,
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
