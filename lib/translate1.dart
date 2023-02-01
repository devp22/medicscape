import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translator/translator.dart';
import 'video_player_widget.dart';

class Translate1 extends StatefulWidget {
  const Translate1({Key? key}) : super(key: key);

  @override
  State<Translate1> createState() => _Translate1State();
}

class _Translate1State extends State<Translate1> {
  late List<String> dos = [];
  late List<String> donts = [];
  late List<String> overview = [];
  late List<String> gujDos = [];
  late List<String> gujDonts = [];
  late List<String> gujOverview = [];
  late List<String> hinOverview = [];
  late String pdf = "";
  late String pdfName = "";
  late String name = "";
  Dio dio = Dio();
  double progress = 0.0;
  late var numberOfDos;
  late var numberOfDonts;
  late var numberOfOverviews = 0;

  bool didDownloadPDF = false;
  String progressString = 'File has not been downloaded yet.';
  Future<void> translateText() async {
    GoogleTranslator translator = GoogleTranslator();
    for (int i = 0; i < numberOfOverviews; i++) {
      await translator.translate(overview[i], to: "hi").then((value) {
        setState(() {
          hinOverview[i] = value.toString();
          print(hinOverview[i]);
        });
      });
    }
  }

  // Text showText(String t) {
  //   return Text(t);
  // }

  Text showText(List<String> t) {
    for (int i = 0; i < numberOfOverviews; i++) {
      return Text(t[i]);
    }
    return Text("");
  }

  void initState() {
    super.initState();
    translateText();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    dos = information["dos"];
    donts = information["donts"];
    overview = information["overviews"];
    // gujDos = information["gujDos"];
    // gujDonts = information["gujDonts"];
    // gujOverview = information["gujOverview"];
    hinOverview = information["overviews"];
    pdf = information["pdf"];
    pdfName = information["pdfName"];
    name = information["name"];
    numberOfOverviews = overview.length;
    numberOfDos = dos.length;
    numberOfDonts = donts.length;
    String condition = information["condition"];
    String? language = "English"; //no radio button will be selected on initial
    bool selectEnglish = true;
    bool selectGujarati = false;
    // List of items in our dropdown menu
    List<String> languages = ['English', 'Gujarati'];
    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          return Future.value(false);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
                child: Column(
              children: [
                ElevatedButton(
                  onPressed: translateText,
                  child: Text("Translate"),
                ),
                showText(hinOverview),
                // ElevatedButton(
                //   onPressed: showText,
                //   child: Text("Show Text"),
                // ),
              ],
            )),
          ),
        ));
  }
}
