import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class HospitalDetails extends StatefulWidget {
  const HospitalDetails({Key? key}) : super(key: key);

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  List<String> addresses = [];
  List<String> names = [];
  List<String> phone = [];

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    addresses = information["addresses"];
    names = information["names"];
    phone = information["phone"];
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
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
            "Hospitals",
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
                      names.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: names.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xfff0f0f0),
                                         borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(5.0),
                                      margin: EdgeInsets.all(10.0),
                                      constraints: const BoxConstraints(
                                          minHeight: 125, minWidth: 100),
                                      child: FittedBox(
                                        alignment: Alignment.topLeft,
                                        fit: BoxFit.fitWidth,
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 400,
                                                  child: Text(
                                                    names[index],
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.getFont(
                                                      "Lato",
                                                      textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF005CA0),
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  child: Text(
                                                    addresses[index],
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.getFont(
                                                      "Lato",
                                                      textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  child: Text(
                                                    phone[index],
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.getFont(
                                                      "Lato",
                                                      textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 6, 85, 41),
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              iconSize: 50,
                                              icon: Icon(Icons.call),
                                              color: Color.fromARGB(
                                                  255, 6, 85, 41),
                                              onPressed: () =>
                                                  FlutterPhoneDirectCaller
                                                      .callNumber(phone[index]),
                                            ),
                                            IconButton(
                                              iconSize: 50,
                                              icon: Icon(Icons.location_pin),
                                              color: Color.fromARGB(
                                                  255, 227, 26, 11),
                                              onPressed: () =>
                                                  MapsLauncher.launchQuery(
                                                      addresses[index]),
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
      ),
    );
  }
}
