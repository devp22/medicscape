import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingContacts extends StatefulWidget {
  const LoadingContacts({Key? key}) : super(key: key);

  @override
  State<LoadingContacts> createState() => _LoadingContactsState();
}

class _LoadingContactsState extends State<LoadingContacts> {
  List<String> numbers = [];
  List<String> names = [];

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("EmergencyContacts")
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        for (int i = 0; i < value.docs.length; i++) {
          numbers.add(value.docs[i].data()["number"].toString());
          names.add(value.docs[i].data()["documentID"].toString());
        }
        print(names);
        print(numbers);
      } else {
        print("Not Found");
      }
    });
    Navigator.pushNamed(context, '/contacts', arguments: {
      "numbers": numbers,
      "names": names,
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
