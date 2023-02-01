import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  List<String> numbers = [];
  List<String> names = [];

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    numbers = information["numbers"];
    names = information["names"];
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
            "Emergency Contacts",
            style: GoogleFonts.getFont("Ubuntu"),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.91,
                  child: Row(
                    children: [
                      numbers.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: numbers.length,
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
                                          minHeight: 100, minWidth: 100),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                names[index],
                                                style: GoogleFonts.getFont(
                                                  "Lato",
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF005CA0),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                numbers[index],
                                                style: GoogleFonts.getFont(
                                                  "Lato",
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF005CA0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            alignment: Alignment.topRight,
                                            onPressed: () => {
                                              FlutterPhoneDirectCaller
                                                  .callNumber(numbers[index]),
                                            },
                                            icon: Icon(
                                              Icons.call,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }))
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
