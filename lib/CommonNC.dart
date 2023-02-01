import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:medicscape/LoadNC.dart';

class CommonNC extends StatefulWidget {
  CommonNC() : super();

  @override
  State<CommonNC> createState() => _CommonNCState();
}

class _CommonNCState extends State<CommonNC> {
  List<String> images = [];
  List<String> name = [];
  List<String> docID = [];
  late String collectionName;

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    images = information["images"];
    name = information["name"];
    docID = information["docID"];
    collectionName = information["collectionName"];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false)
          },
        ),
        backgroundColor: Color(0xFF005CA0),
        title: Text(
          collectionName,
          style: GoogleFonts.getFont("Ubuntu"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.91,
                child: Row(
                  children: [
                    name.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: name.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => LoadNC(
                                              conditionName: collectionName,
                                              docID: docID[index]),
                                        ),
                                      ),
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff0f0f0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(5.0),
                                      margin: EdgeInsets.all(10.0),
                                      constraints: const BoxConstraints(
                                          minHeight: 100, minWidth: 100),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 90.0,
                                            height: 90.0,
                                            margin: EdgeInsets.fromLTRB(
                                                10, 10, 30, 10),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              imageUrl: images[index],
                                            ),
                                            // decoration: BoxDecoration(
                                            //   shape: BoxShape.rectangle,
                                            //   borderRadius:
                                            //       const BorderRadius.all(
                                            //           Radius.circular(10)),
                                            //   image: DecorationImage(
                                            //     fit: BoxFit.fill,
                                            //     image: Cac
                                            //   ),
                                            // ),
                                          ),
                                          Text(
                                            name[index],
                                            style: GoogleFonts.getFont(
                                              "Lato",
                                              textStyle: TextStyle(
                                                color: Color(0xFF005CA0),
                                              ),
                                            ),
                                          ),
                                        ],
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
