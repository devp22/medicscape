import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  late String cardName;
  late String displayName;
  Loading({required this.cardName, required this.displayName}) : super();

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String cardName = widget.cardName;
  late String displayName = widget.displayName;
  List<String> images = [];
  List<String> name = [];
  List<String> docName = [];
  // List<String> cardNames = [];
  // List<String> phone = [];

  Future<void> getData() async {
    await FirebaseFirestore.instance.collection(cardName).get().then((value) {
      if (value.docs.length > 0) {
        for (int i = 0; i < value.docs.length; i++) {
          images.add(value.docs[i].data()["image"].toString());
          name.add(value.docs[i].data()["name"].toString());
          docName.add(value.docs[i].data()["documentID"].toString());
        }
        print("GOT DATA");
      } else {
        print("Not Found");
      }
    });
    print("SENDING DATA");
    Navigator.pushNamed(context, '/commoncard', arguments: {
      "images": images,
      "name": name,
      "collectionName": cardName,
      "displayName": displayName,
      "docName": docName,
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
