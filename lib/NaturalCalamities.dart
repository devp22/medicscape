import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:permission_handler/permission_handler.dart';
import 'video_player_widget.dart';

class NaturalCalamities extends StatefulWidget {
  const NaturalCalamities({Key? key}) : super(key: key);

  @override
  State<NaturalCalamities> createState() => _NaturalCalamitiesState();
}

class _NaturalCalamitiesState extends State<NaturalCalamities> {
  late List<String> dos = [
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
  late List<String> donts = [
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
  late List<String> overview = [
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
  Dio dio = Dio();
  double progress = 0.0;
  late String pdf;
  late String pdfName;
  late var numberOfDos;
  late var numberOfDonts;
  late var numberOfOverviews;

  bool didDownloadPDF = false;
  String progressString = 'File has not been downloaded yet.';
  void initState() {
    // getData();
    // Firebase.initializeApp();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    dos = information["dos"];
    donts = information["donts"];
    overview = information["overviews"];
    pdf = information["pdf"];
    pdfName = information["pdfName"];
    numberOfOverviews = overview.length;
    numberOfDos = dos.length;
    numberOfDonts = donts.length;
    String cardName = information["cardName"];
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
            cardName,
            style: GoogleFonts.getFont("Ubuntu"),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
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
              overview.isNotEmpty
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
                              return Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Text(
                                  '${overview[index]}',
                                  style: GoogleFonts.getFont(
                                    "Lato",
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
              dos.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            "Do's:",
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
                              itemCount: numberOfDos,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 10),
                                      child: Text(
                                        '${index + 1}) ${dos[index]}',
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
              donts.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            "Don'ts:",
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
                              itemCount: numberOfDonts,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 10),
                                      child: Text(
                                        '${index + 1}) ${donts[index]}',
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
            ],
          ),
        ),
      ),
    );
  }
}
