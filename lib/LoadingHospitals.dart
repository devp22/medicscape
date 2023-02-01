import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingHospitals extends StatefulWidget {
  const LoadingHospitals({Key? key}) : super(key: key);

  @override
  State<LoadingHospitals> createState() => _LoadingHospitalsState();
}

class _LoadingHospitalsState extends State<LoadingHospitals> {
  List<String> addresses = [];
  List<String> names = [];
  List<String> phone = [];
  late String city;
  late String sublocality;
  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("HospitalDetails")
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        for (int i = 0; i < value.docs.length; i++) {
          if (value.docs[i].data()["sublocality"].toString() == sublocality) {
            names.add(value.docs[i].data()["name"].toString());
            addresses.add(value.docs[i].data()["address"].toString());
            phone.add(value.docs[i].data()["phone"].toString());
          }
        }
        print("GOT DATA");
      } else {
        print("Not Found");
      }
    });
    print("SENDING DATA");
    Navigator.pushNamed(context, '/hospitals', arguments: {
      "addresses": addresses,
      "names": names,
      "phone": phone,
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
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    city = information["city"];
    sublocality = information["sublocality"];
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
