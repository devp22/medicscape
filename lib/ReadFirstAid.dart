import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadFirstAid extends StatefulWidget {
  ReadFirstAid() : super();

  @override
  State<ReadFirstAid> createState() => _ReadFirstAidState();
}

class _ReadFirstAidState extends State<ReadFirstAid> {
  late List<String> points = [];
  late String title;
  late var numberOfPoints;
  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    points = information["points"];
    title = information["title"];
    numberOfPoints = points.length;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF005CA0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (route) => false)
            },
          ),
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
          // scrollDirection: Axis.vertical,
          // physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        '${points[index]}',
                                        style: GoogleFonts.getFont(
                                          "Ubuntu",
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
            ],
          ),
        ),
      ),
    );
  }
}
