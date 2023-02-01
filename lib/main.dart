import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/services.dart';
import 'package:medicscape/AboutUs.dart';
import 'package:medicscape/CommonNC.dart';
import 'package:medicscape/EmergencyContact.dart';
import 'package:medicscape/FirstAidKit.dart';
import 'package:medicscape/HospitalDetails.dart';
import 'package:medicscape/LoadingFinalFirstAid.dart';
import 'package:medicscape/LoadingHospitals.dart';
import 'package:medicscape/NaturalCala2.dart';
import 'package:medicscape/NaturalCalamities.dart';
import 'package:medicscape/RateUs.dart';
import 'package:medicscape/ReadFirstAid.dart';
import 'package:medicscape/ReadSplint.dart';
import 'package:medicscape/Sample2.dart';
import 'package:medicscape/SplashScreen.dart';
import 'package:medicscape/commoncard.dart';
import 'package:medicscape/homepage.dart';
import 'package:medicscape/infocard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicscape/location_screen.dart';
import 'package:medicscape/pdf_download.dart';
import 'package:medicscape/sampleScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medicscape/translate1.dart';

Future<void> main() async {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyHomePage());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        "/commoncard": (context) => CommonCard(),
        "/translate1": (context) => Translate1(),
        "/commonnc": (context) => CommonNC(),
        // "/naturalcala": (context) => NaturalCala2(
        // ),
        "/home": (context) => const HomePage(),
        "/info": (context) => InfoCard(),
        "/contacts": (context) => EmergencyContact(),
        "/hospitals": (context) => HospitalDetails(),
        "/readfirstaid": (context) => ReadFirstAid(),
        "/readsplint": (context) => ReadSplint(),
        "/readfirstaidkit": (context) => FirstAidKit(),
        "/sample2": (context) => Sample2(),
        "/loadhospitals": (context) => LoadingHospitals(),
        // "/loadfinalfirstaid": (context) => LoadFinalFirstAid(),

        "/nc": (context) => NaturalCalamities(),
      }, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
