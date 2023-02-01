import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

GestureDetector FirstAidCards(
    String title, MaterialPageRoute mpr, BuildContext context) {
  return GestureDetector(
    onTap: (() => Navigator.of(context).push(mpr)),
    child: Container(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height / 8,
          minWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Color(0xfff0f0f0)),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: GoogleFonts.getFont(
            "Prompt",
            textStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}

GestureDetector homePageCards(
    String title, MaterialPageRoute mpr, BuildContext context, String iconAdd) {
  return GestureDetector(
    onTap: (() => Navigator.of(context).push(mpr)),
    child: Container(
      constraints: BoxConstraints(
          minHeight: 150, minWidth: 150, maxHeight: 150, maxWidth: 150),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Color(0xfff0f0f0),
      ),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconAdd,
            scale: 6,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
          // FittedBox(
          //   fit: BoxFit.fitWidth,
          //   child: Text(
          //     title,
          //     style: GoogleFonts.getFont("Ubuntu"),
          //   ),
          // ),
        ],
      ),
    ),
  );
}

Text aboutUsHeader(String text) {
  return Text(
    text,
    style: GoogleFonts.getFont(
      'Lato',
      textStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Color(0xFF005CA0),
      ),
    ),
  );
}

Text aboutUsText(String text) {
  return Text(
    text,
    style: GoogleFonts.getFont(
      'Lato',
      textStyle: TextStyle(fontSize: 15),
    ),
  );
}
