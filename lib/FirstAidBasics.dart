import 'package:flutter/material.dart';
import 'package:medicscape/FirstAidBasicsMain.dart';
import 'package:medicscape/FirstAidKit.dart';
import 'package:medicscape/LoadFirstAidKit.dart';
import 'package:medicscape/LoadSplint.dart';
import 'package:medicscape/LoadingFirstAid.dart';
import 'package:medicscape/Splint.dart';
import 'package:medicscape/reusablewidgets.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstAidBasics extends StatefulWidget {
  const FirstAidBasics({Key? key}) : super(key: key);

  @override
  State<FirstAidBasics> createState() => _FirstAidBasicsState();
}

class _FirstAidBasicsState extends State<FirstAidBasics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005CA0),
        title: Text(
          "First Aid Basics",
          style: GoogleFonts.getFont(
            "Lato",
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (() => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => LoadingFirstAid(
                                cardName: "FirstAidBasics",
                              )),
                    )),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 10,
                      minWidth: MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Color(0xfff0f0f0)),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Everything About First Aid",
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
              ),
              // GestureDetector( 
              GestureDetector(
                onTap: (() => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => LoadFirstAidKit(
                                title: "What should be in a First Aid Kit?",
                              )),
                    )),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 10,
                      minWidth: MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Color(0xfff0f0f0)),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "What should be in a First Aid Kit?",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
