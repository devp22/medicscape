import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:permission_handler/permission_handler.dart';
import 'video_player_widget.dart';

class InfoCard extends StatefulWidget {
  InfoCard({Key? key}) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  Dio dio = Dio();
  double progress = 0.0;
  late String videoURL;
  late String pdf;
  late String pdfName;
  late List<String> symptoms = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  late List<String> overviews = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  late List<String> remedies = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  late List<String> causes = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  // late String conditonName = widget.conditionName;
  // late String cardName = widget.cardName;
  late var numberOfSymptoms;
  late var numberOfRemedies;
  late var numberOfOverviews;
  late var numberOfCauses;
  late var name;
  bool didDownloadPDF = false;
  String progressString = 'File has not been downloaded yet.';

  void updateProgress(done, total) {
    progress = done / total;
    setState(() {
      if (progress >= 1) {
        progressString =
            '✅ File has finished downloading. Try opening the file.';
        didDownloadPDF = true;
      } else {
        progressString = 'Download progress: ' +
            (progress * 100).toStringAsFixed(0) +
            '% done.';
      }
    });
  }

  Future<void> downloadPDF(Dio dio, String url, String savePath) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();
    if (pdf.isNotEmpty) {
      Fluttertoast.showToast(msg: "Checking permission");
      if (statuses[Permission.storage]!.isGranted) {
        try {
          Fluttertoast.showToast(msg: "Download Started");

          Response response = await dio.get(
            url,
            onReceiveProgress: updateProgress,
            options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                }),
          );
          var file = File(savePath).openSync(mode: FileMode.write);
          file.writeFromSync(response.data);
          await file.close();
          Fluttertoast.showToast(
              msg: "PDF downloaded", toastLength: Toast.LENGTH_LONG);
        } catch (e) {
          print("ERROR DOWNLOADING: " + e.toString());
        }
      } else {
        Fluttertoast.showToast(
            msg: "No permission to read and write.",
            toastLength: Toast.LENGTH_LONG);
      }
    } else {
      Fluttertoast.showToast(
          msg: "No PDF available", toastLength: Toast.LENGTH_LONG);
    }
  }

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    symptoms = information["symptoms"];
    remedies = information["remedies"];
    overviews = information["overviews"];
    causes = information["causes"];
    name = information["name"];
    videoURL = information["video"].toString();
    print("VIDEO URL: " + videoURL);
    pdf = information["pdf"];
    print("PDF::::::" + pdf.toString());
    pdfName = information["pdfName"];
    numberOfOverviews = overviews.length;
    numberOfSymptoms = symptoms.length;
    numberOfRemedies = remedies.length;
    numberOfCauses = causes.length;
    String condition = information["condition"];
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
            name,
            style: GoogleFonts.getFont("Ubuntu"),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: GestureDetector(
                child: Icon(Icons.picture_as_pdf),
                onTap: () async {
                  var tempDir = await getTemporaryDirectory();
                  downloadPDF(Dio(), pdf.toString(),
                      "/storage/emulated/0/Download/" + pdfName);
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              overviews.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            "OVERVIEW",
                            style: GoogleFonts.getFont(
                              "Lato",
                              textStyle: TextStyle(
                                color: Color(0xFF005CA0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 4,
                          indent: 20,
                          endIndent: 20,
                          color: Color(0xFF005CA0),
                          height: 20,
                        ),
                        Container(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numberOfOverviews,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Text(
                                        '${overviews[index]}',
                                        style: GoogleFonts.getFont(
                                          "Lato",
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    )
                  : Container(),
              causes.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            "CAUSES",
                            style: GoogleFonts.getFont(
                              "Lato",
                              textStyle: TextStyle(
                                color: Color(0xFF005CA0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 4,
                          indent: 20,
                          endIndent: 20,
                          color: Color(0xFF005CA0),
                          height: 20,
                        ),
                        Container(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numberOfCauses,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 10),
                                      child: Text(
                                        '${index + 1}) ${causes[index]}',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          "Lato",
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              symptoms.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            "SYMPTOMS",
                            style: GoogleFonts.getFont(
                              "Lato",
                              textStyle: TextStyle(
                                color: Color(0xFF005CA0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 5, // thickness of the line
                          indent:
                              20, // empty space to the leading edge of divider.
                          endIndent:
                              20, // empty space to the trailing edge of the divider.
                          color: Color(
                              0xFF005CA0), // The color to use when painting the line.
                          height: 20, // The divider's height extent.
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(10),
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numberOfSymptoms,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 20),
                                      child: Text(
                                        '${index + 1}) ${symptoms[index]}',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          "Lato",
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    )
                  : Container(),
              overviews.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            "REMEDIES",
                            style: GoogleFonts.getFont(
                              "Lato",
                              textStyle: TextStyle(
                                color: Color(0xFF005CA0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 5, // thickness of the line
                          indent:
                              20, // empty space to the leading edge of divider.
                          endIndent:
                              20, // empty space to the trailing edge of the divider.
                          color: Color(
                              0xFF005CA0), // The color to use when painting the line.
                          height: 20, // The divider's height extent.
                        ),
                        Container(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: numberOfRemedies,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 20),
                                      child: Text(
                                        '${index + 1}) ${remedies[index]}',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          "Lato",
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    )
                  : Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "VIDEO",
                      style: GoogleFonts.getFont(
                        "Lato",
                        textStyle: TextStyle(
                          color: Color(0xFF005CA0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 4,
                    indent: 20,
                    endIndent: 20,
                    color: Color(0xFF005CA0),
                    height: 20,
                  ),
                  videoURL.isNotEmpty
                      ? Container(
                          child: VideoPlayerWidget(url: videoURL),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Text(
                            "NO VIDEO AVAILABLE",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.getFont(
                              "Lato",
                              textStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
