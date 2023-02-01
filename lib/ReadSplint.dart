import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadSplint extends StatefulWidget {
  const ReadSplint({Key? key}) : super(key: key);

  @override
  State<ReadSplint> createState() => _ReadSplintState();
}

class _ReadSplintState extends State<ReadSplint> {
  late List<String> points = [];
  late String documentID;
  late String title;
  late var numberOfPoints;
  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    points = information["points"];
    documentID = information["documentID"];
    title = information["title"];
    numberOfPoints = points.length;

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
          title: Text(title),
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
          child: Container(
            child: Column(
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
      ),
    );
  }
}
