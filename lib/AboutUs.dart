import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reusablewidgets.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              "About Us",
              style: GoogleFonts.getFont("Ubuntu"),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: aboutUsHeader("Motive of this app")),
                  ),
                  const Divider(
                    thickness: 4,
                    indent: 20,
                    endIndent: 20,
                    color: Color(0xFF005CA0),
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        aboutUsText(
                            "Our mission is to provide relief in times of disaster/emergencies and empower people to take care of their health."),
                        SizedBox(height: 10),
                        aboutUsText(
                            "This application enables you to assist persons who become injured in the event of an accident or emergency situation until help arrives. It is comprised of relatively simple techniques and procedures that can be performed with limited equipment and is typically carried out until professional medical assistance arrives."),
                        SizedBox(
                          height: 10,
                        ),
                        aboutUsText(
                            "We ensure that the contents of modules are accurate and correct. "),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: aboutUsHeader("Future scope")),
                  ),
                  const Divider(
                    thickness: 4,
                    indent: 20,
                    endIndent: 20,
                    color: Color(0xFF005CA0),
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        aboutUsText("* Language Translation"),
                        SizedBox(
                          height: 10,
                        ),
                        aboutUsText(
                            "* Nearby Hospitals across anywhere in world"),
                        SizedBox(
                          height: 10,
                        ),
                        aboutUsText("* Contact nearby volunteers and doctors"),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: aboutUsHeader("App Developers")),
                  ),
                  const Divider(
                    thickness: 4,
                    indent: 20,
                    endIndent: 20,
                    color: Color(0xFF005CA0),
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        aboutUsText(
                            "This app has been created by Team Aakalp."),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
