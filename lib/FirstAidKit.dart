import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstAidKit extends StatefulWidget {
  const FirstAidKit({Key? key}) : super(key: key);

  @override
  State<FirstAidKit> createState() => _FirstAidKitState();
}

class _FirstAidKitState extends State<FirstAidKit> {
  late List<String> points = [];
  late String documentID;
  late String title;
  late var numberOfPoints;
  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    points = information["points"];
    documentID = information["documentID"];
    title = information["title"];
    numberOfPoints = points.length;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (route) => false)
            },
          ),
          backgroundColor: Color(0xFF005CA0),
          title: Text(
            title,
            style: GoogleFonts.getFont(
              "Lato",
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
          //     child: GestureDetector(
          //       child: Icon(Icons.picture_as_pdf),
          //       onTap: () => {},
          //     ),
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                points.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: numberOfPoints,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      '${index + 1}) ${points[index]}',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.getFont(
                                        "Lato",
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
