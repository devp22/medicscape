// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:dio/dio.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'video_player_widget.dart';

// class NaturalCala2 extends StatefulWidget {
//   const NaturalCala2({Key? key}) : super(key: key);

//   @override
//   State<NaturalCala2> createState() => _NaturalCala2State();
// }

// class _NaturalCala2State extends State<NaturalCala2> {
//   late List<String> dos = [];
//   late List<String> donts = [];
//   late List<String> overview = [];
//   late List<String> gujDos = [];
//   late List<String> gujDonts = [];
//   late List<String> gujOverview = [];
//   late String pdf = "";
//   late String pdfName = "";
//   late String name = "";

//   Dio dio = Dio();
//   double progress = 0.0;
//   late var numberOfDos;
//   late var numberOfDonts;
//   late var numberOfOverviews;

//   bool didDownloadPDF = false;
//   String progressString = 'File has not been downloaded yet.';
//   void initState() {
//     super.initState();
//   }

//   void dispose() {
//     super.dispose();
//   }

//   void updateProgress(done, total) {
//     progress = done / total;
//     setState(() {
//       if (progress >= 1) {
//         progressString =
//             '✅ File has finished downloading. Try opening the file.';
//         didDownloadPDF = true;
//       } else {
//         progressString = 'Download progress: ' +
//             (progress * 100).toStringAsFixed(0) +
//             '% done.';
//       }
//     });
//   }

//   Future<void> downloadPDF(Dio dio, String url, String savePath) async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//       //add more permission to request here.
//     ].request();
//     if (pdf.isNotEmpty) {
//       Fluttertoast.showToast(msg: "Checking permission");
//       if (statuses[Permission.storage]!.isGranted) {
//         try {
//           Fluttertoast.showToast(msg: "Download Started");

//           Response response = await dio.get(
//             url,
//             onReceiveProgress: updateProgress,
//             options: Options(
//                 responseType: ResponseType.bytes,
//                 followRedirects: false,
//                 validateStatus: (status) {
//                   return status! < 500;
//                 }),
//           );
//           var file = File(savePath).openSync(mode: FileMode.write);
//           file.writeFromSync(response.data);
//           await file.close();
//           Fluttertoast.showToast(
//               msg: "PDF downloaded", toastLength: Toast.LENGTH_LONG);
//         } catch (e) {
//           print("ERROR DOWNLOADING: " + e.toString());
//         }
//       } else {
//         Fluttertoast.showToast(
//             msg: "No permission to read and write.",
//             toastLength: Toast.LENGTH_LONG);
//       }
//     } else {
//       Fluttertoast.showToast(
//           msg: "No PDF available", toastLength: Toast.LENGTH_LONG);
//     }
//   }

//   Widget showEnglish() {
//     return overview.isNotEmpty
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 child: Text(
//                   "OVERVIEW",
//                   style: GoogleFonts.getFont(
//                     "Lato",
//                     textStyle: TextStyle(
//                       color: Color(0xFF005CA0),
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const Divider(
//                 thickness: 4,
//                 indent: 20,
//                 endIndent: 20,
//                 color: Color(0xFF005CA0),
//                 height: 20,
//               ),
//               Container(
//                 child: ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: numberOfOverviews,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
//                       child: Text(
//                         '${gujOverview[index]}',
//                         style: GoogleFonts.getFont(
//                           "Lato",
//                           textStyle: TextStyle(
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           )
//         : Container();
//   }

//   Widget showGujarati() {
//     return gujOverview.isNotEmpty
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 child: Text(
//                   "OVERVIEW",
//                   style: GoogleFonts.getFont(
//                     "Lato",
//                     textStyle: TextStyle(
//                       color: Color(0xFF005CA0),
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const Divider(
//                 thickness: 4,
//                 indent: 20,
//                 endIndent: 20,
//                 color: Color(0xFF005CA0),
//                 height: 20,
//               ),
//               Container(
//                 child: ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: numberOfOverviews,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
//                       child: Text(
//                         '${gujOverview[index]}',
//                         style: GoogleFonts.getFont(
//                           "Lato",
//                           textStyle: TextStyle(
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           )
//         : Container();
//   }

//   int f = 0;
//   void changeValue(var value) {
//     setState(() {
//       f = value as int;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Map information = ModalRoute.of(context)?.settings.arguments as Map;
//     dos = information["dos"];
//     donts = information["donts"];
//     overview = information["overviews"];
//     gujDos = information["gujDos"];
//     gujDonts = information["gujDonts"];
//     gujOverview = information["gujOverview"];
//     pdf = information["pdf"];
//     pdfName = information["pdfName"];
//     name = information["name"];
//     numberOfOverviews = overview.length;
//     numberOfDos = dos.length;
//     numberOfDonts = donts.length;
//     String condition = information["condition"];
//     String? language = "English"; //no radio button will be selected on initial
//     bool selectEnglish = true;
//     bool selectGujarati = false;
//     // List of items in our dropdown menu
//     List<String> languages = ['English', 'Gujarati'];
//     return WillPopScope(
//       onWillPop: () {
//         Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
//         return Future.value(false);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => {
//               Navigator.pushNamedAndRemoveUntil(
//                   context, "/home", (route) => false)
//             },
//           ),
//           backgroundColor: Color(0xFF005CA0),
//           title: Text(
//             condition,
//             style: GoogleFonts.getFont("Ubuntu"),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
//               child: GestureDetector(
//                 child: Icon(Icons.picture_as_pdf),
//                 onTap: () async {
//                   var tempDir = await getTemporaryDirectory();
//                   downloadPDF(Dio(), pdf.toString(),
//                       "/storage/emulated/0/Download/" + pdfName);
//                 },
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Column(
//                 children: [
//                   Checkbox(
//                       value: f,
//                       onChanged: (value) {
//                         changeValue(value);
//                       }),
//                 ],
//               ),
//               // if (language.) showGujarati() else showEnglish(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
