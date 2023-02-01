import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';




class LoadingSplint extends StatefulWidget {
    late String cardName;

   LoadingSplint({required this.cardName}) : super();

  @override
  State<LoadingSplint> createState() => _LoadingSplintState();
}

class _LoadingSplintState extends State<LoadingSplint> {
 late String cardName = widget.cardName;
  List<String> documentID = [];
  List<String> names = [];
  Future<void> getData() async {
    await FirebaseFirestore.instance.collection(cardName).get().then((value) {
      if (value.docs.length > 0) {
        for (int i = 0; i < value.docs.length; i++) {
          documentID.add(value.docs[i].data()["documentID"].toString());
          names.add(value.docs[i].data()["name"].toString());
          print("NAME: " + names[i]);
        }
      } else {
        print("Not Found");
      }
    });
    Navigator.pushNamed(context, '/finalfirstaid', arguments: {
      "names": names,
      "documentID": documentID,
      "cardName": cardName,
    });
  }

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Loading Splint data"),
    );
  }
}