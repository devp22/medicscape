import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicscape/LoadFinalSplint.dart';
import 'package:medicscape/LoadingFinalFirstAid.dart';
import 'package:medicscape/ReadFirstAid.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadSplint extends StatefulWidget {
  late String cardName;
  LoadSplint({required this.cardName}) : super();

  @override
  State<LoadSplint> createState() => _LoadSplintState();
}

class _LoadSplintState extends State<LoadSplint> {
  late String cardName = widget.cardName;
  List<String> names = ["Whatissplint", "Whatyouwillneedforsplintinganinjury"];
  List<String> listnames = ["What is splint?", "Splinting an injury"];
  void initState() {
    super.initState();
    // Firebase.initializeApp().whenComplete(() => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005CA0),
        title: Text(
          "Splint",
          style: GoogleFonts.getFont(
            "Lato",
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
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
                                          builder: (context) => LoadFinalSplint(
                                            cardName: cardName,
                                            documentID: names[index],
                                            title: listnames[index],
                                          ),
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
                                      constraints: BoxConstraints(
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                          minWidth: MediaQuery.of(context)
                                              .size
                                              .width),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          listnames[index],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.getFont(
                                            "Lato",
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF005CA0),
                                            ),
                                          ),
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
