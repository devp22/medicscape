import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:medicscape/infocard.dart';
import 'package:medicscape/loadingData.dart';
import 'package:medicscape/sampleScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommonCard extends StatefulWidget {
  CommonCard() : super();

  @override
  State<CommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<CommonCard> {
  List<String> images = [];
  List<String> name = [];
  late String collectionName;
  late String displayName;
  List<String> docName = [];

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future<void> loadImage(String url, int index) async {
    await Image.network(
      images[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    images = information["images"];
    name = information["name"];
    docName = information["docName"];
    displayName = information["displayName"];
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
                                          builder: (context) => LoadingData(
                                              collectionName: collectionName,
                                              documentName: docName[index]),
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
      // body: SingleChildScrollView(
      //   child: Container(
      //     decoration: BoxDecoration(color: Colors.white),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           height: MediaQuery.of(context).size.height * 0.91,
      //           child: Row(
      //             children: [
      //               _items.isNotEmpty
      //                   ? Expanded(
      //                       child: ListView.builder(
      //                           scrollDirection: Axis.vertical,
      //                           itemCount: _items.length,
      //                           itemBuilder: (context, index) {
      //                             return GestureDetector(
      //                               onTap: () => {
      //                                 Navigator.of(context).push(
      //                                   MaterialPageRoute(
      //                                     builder: (context) => LoadingData(
      //                                       conditionName: _items[index]
      //                                           ["DBName"],
      //                                       cardName: JSONcardName,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               },
      //                               child: Container(
      //                                 decoration: BoxDecoration(
      //                                   color: Color(0xfff0f0f0),
      //                                   borderRadius: BorderRadius.all(
      //                                     Radius.circular(5),
      //                                   ),
      //                                 ),
      //                                 padding: EdgeInsets.all(5.0),
      //                                 margin: EdgeInsets.all(10.0),
      //                                 constraints: const BoxConstraints(
      //                                     minHeight: 100, minWidth: 100),
      //                                 child: Row(
      //                                   children: [
      //                                     Container(
      //                                       width: 90.0,
      //                                       height: 90.0,
      //                                       margin: EdgeInsets.fromLTRB(
      //                                           10, 10, 30, 10),
      //                                       decoration: BoxDecoration(
      //                                         shape: BoxShape.rectangle,
      //                                         borderRadius:
      //                                             const BorderRadius.all(
      //                                                 Radius.circular(10)),
      //                                         image: DecorationImage(
      //                                           fit: BoxFit.fill,
      //                                           image: AssetImage(
      //                                             _items[index]["Image"],
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     Text(
      //                                       _items[index]["Name"],
      //                                       style: GoogleFonts.getFont(
      //                                         "Lato",
      //                                         textStyle: TextStyle(
      //                                           color: Color(0xFF005CA0),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             );
      //                           }))
      //                   : Container()
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
