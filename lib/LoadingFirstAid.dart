import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicscape/LoadingFinalFirstAid.dart';
import 'package:medicscape/ReadFirstAid.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingFirstAid extends StatefulWidget {
  late String cardName;
  LoadingFirstAid({required this.cardName}) : super();

  @override
  State<LoadingFirstAid> createState() => _LoadingFirstAidState();
}

class _LoadingFirstAidState extends State<LoadingFirstAid> {
  late String cardName = widget.cardName;
  List<String> names = [
    "FirstAidBandage",
    "LearnthefirstaidmethodofABCD",
    "WhatisFirstAid"
  ];
  List<String> listnames = [
    "First Aid Bandage",
    "Learn the first aid method of ABCD",
    "What is First Aid ?"
  ];
  // Future<void> getData() async {
  //   await FirebaseFirestore.instance.collection(cardName).get().then((value) {
  //     if (value.docs.length > 0) {
  //       for (int i = 0; i < value.docs.length; i++) {
  //         documentID.add(value.docs[i].data()["documentID"].toString());
  //         names.add(value.docs[i].data()["name"].toString());
  //         print("NAME: " + names[i]);
  //       }
  //     } else {
  //       print("Not Found");
  //     }
  //   });
  //   Navigator.pushNamed(context, '/finalfirstaid', arguments: {
  //     "names": names,
  //     "documentID": documentID,
  //     "cardName": cardName,
  //   });
  // }

  void initState() {
    super.initState();
    // Firebase.initializeApp().whenComplete(() => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Everything About First Aid",
          style: GoogleFonts.getFont(
            "Lato",
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color(0xFF005CA0),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    names.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: names.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoadFinalFirstAid(
                                            cardName: cardName,
                                            documentID: names[index],
                                            title: listnames[index],
                                          ),
                                        ),
                                      ),
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xfff0f0f0),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(5.0),
                                        margin: EdgeInsets.all(10.0),
                                        constraints: BoxConstraints(
                                            minHeight: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width),
                                        child: Row(
                                          children: [
                                            Text(
                                              listnames[index],
                                              style: GoogleFonts.getFont(
                                                "Lato",
                                                textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFF005CA0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }))
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
