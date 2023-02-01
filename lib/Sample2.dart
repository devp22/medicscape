import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicscape/Sample3.dart';

class Sample2 extends StatefulWidget {
  const Sample2({Key? key}) : super(key: key);

  @override
  State<Sample2> createState() => _Sample2State();
}

class _Sample2State extends State<Sample2> {
  List<String> images = [];
  List<String> documentID = [];
  late String collectionName;

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map information = ModalRoute.of(context)?.settings.arguments as Map;
    images = information["images"];
    documentID = information["documentID"];
    collectionName = information["collectionName"];

    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Natural Calamities "),
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
                        documentID.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: documentID.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () => {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Sample3(
                                                  collectionName:
                                                      collectionName,
                                                  documentName:
                                                      documentID[index]),
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
                                                child: Image.network(
                                                  images[index],
                                                ),
                                                // decoration: BoxDecoration(
                                                //   shape: BoxShape.rectangle,
                                                //   borderRadius:
                                                //       const BorderRadius.all(
                                                //           Radius.circular(10)),
                                                //   image: DecorationImage(
                                                //     fit: BoxFit.fill,
                                                //     image: NetworkImage(
                                                //       url
                                                //       images[index],
                                                //     ),
                                                //   ),
                                                // ),
                                              ),
                                              Text(
                                                documentID[index],
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
        ));
  }
}
