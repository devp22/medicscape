// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicscape/AboutUs.dart';
import 'package:medicscape/CommonNC.dart';
import 'package:medicscape/EmergencyContact.dart';
import 'package:medicscape/FirstAidBasics.dart';
import 'package:medicscape/LoadNC.dart';
import 'package:medicscape/LoadNC1.dart';
import 'package:medicscape/LoadSplint.dart';
import 'package:medicscape/LoadingCard.dart';
import 'package:medicscape/LoadingHospitals.dart';
import 'package:medicscape/RateUs.dart';
import 'package:medicscape/commoncard.dart';
import 'package:medicscape/loadingContacts.dart';
import 'package:medicscape/location_screen.dart';
import 'reusablewidgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  PageController pgc = PageController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005CA0),
        title: Text(
          "Home Page",
          style: GoogleFonts.getFont("Ubuntu"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  Text(
                    'Medicscape',
                    style: GoogleFonts.getFont(
                      "Ubuntu",
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: const Image(
                      height: 80,
                      width: 80,
                      image: AssetImage(
                        "assets/images/splashscreenlogo1.png",
                      ),
                    ),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF005CA0),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: Text(
                'Share',
                style: GoogleFonts.getFont("Ubuntu"),
              ),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(
                'Contact Developer',
                style: GoogleFonts.getFont("Ubuntu"),
              ),
              onTap: () {
                String email = Uri.encodeComponent("aakalp.team@gmail.com");
                String subject = Uri.encodeComponent("Problem with Medicscape");
                print(subject);
                Uri mail = Uri.parse("mailto:$email?subject=$subject");
                launchUrl(mail);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: Text(
                'Rate us',
                style: GoogleFonts.getFont("Ubuntu"),
              ),
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RateUs(),
                  ),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(
                'About Us',
                style: GoogleFonts.getFont("Ubuntu"),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(
                'Close',
                style: GoogleFonts.getFont("Ubuntu"),
              ),
              onTap: () => {SystemNavigator.pop()},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ConstrainedBox(
            //   constraints: BoxConstraints.expand(
            //     height: size.height / 2.5,
            //     width: size.width,
            //   ),
            // child: CarouselSlider(
            //   items: [
            //     //1st Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/1.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //     //2nd Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/2.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //     //3rd Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/3.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //     //4th Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/4.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //     //5th Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/5.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //     //6th Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/6.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //     //7th Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/7.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //     //8th Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/8.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //     //9th Image of Slider
            //     Container(
            //       child: Image.asset(
            //         "assets/images/carousel/9.jpg",
            //         height: size.height / 2.5,
            //         width: size.width,
            //       ),
            //     ),
            //   ],

            //   //Slider Container properties
            //   options: CarouselOptions(
            //     height: size.height / 1.5,
            //     enlargeCenterPage: true,
            //     autoPlay: true,
            //     aspectRatio: 16 / 9,
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     enableInfiniteScroll: true,
            //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
            //     viewportFraction: 0.8,
            //   ),
            // ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homePageCards(
                    "First Aid",
                    MaterialPageRoute(
                        builder: (context) => const FirstAidBasics()),
                    context,
                    "assets/images/firstaid.png"),
                homePageCards(
                    "Common Conditions",
                    MaterialPageRoute(
                        builder: (context) => Loading(
                              cardName: "CommonConditions",
                              displayName: "Common Conditions",
                            )),
                    context,
                    "assets/images/stomachache.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homePageCards(
                    "Emergency Response",
                    MaterialPageRoute(
                      builder: (context) => Loading(
                        cardName: "EmergencyResponse",
                        displayName: "Emergency Response",
                      ),
                    ),
                    context,
                    "assets/images/cpr.png"),
                homePageCards(
                    "Critical Conditions",
                    MaterialPageRoute(
                      builder: (context) => Loading(
                        cardName: "CriticalConditions",
                        displayName: "Critical Conditions",
                      ),
                    ),
                    context,
                    "assets/images/criticalconditions.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homePageCards(
                    "Natural Calamities",
                    MaterialPageRoute(
                      builder: (context) =>
                          LoadNC1(cardName: "NaturalCalamities"),
                    ),
                    context,
                    "assets/images/earthquake.png"),
                homePageCards(
                    "Emergency Contacts",
                    MaterialPageRoute(
                        builder: (context) => const LoadingContacts()),
                    context,
                    "assets/images/emergencycontacts.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homePageCards(
                    "Nearby Hospitals",
                    MaterialPageRoute(
                        builder: (context) => const LocationScreen()),
                    context,
                    "assets/images/hospital.png"),
                homePageCards(
                    "Splint",
                    MaterialPageRoute(
                        builder: (context) => LoadSplint(
                              cardName: "Splint",
                            )),
                    context,
                    "assets/images/splint.png"),
                // GestureDetector(
                //   onTap: (() => {}),
                //   child: Container(
                //     constraints: BoxConstraints(
                //         minHeight: 150,
                //         minWidth: 150,
                //         maxHeight: 150,
                //         maxWidth: 150),
                //     decoration: BoxDecoration(
                //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                //       color: Color(0xfff0f0f0),
                //     ),
                //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                //     margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                //     child: Column(
                //       children: [
                //         Image.asset("assets/images/comingsoon.jpeg"),
                //         // FittedBox(
                //         //   fit: BoxFit.fitWidth,
                //         //   child: Text(
                //         //     title,
                //         //     style: GoogleFonts.getFont("Ubuntu"),
                //         //   ),
                //         // ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
