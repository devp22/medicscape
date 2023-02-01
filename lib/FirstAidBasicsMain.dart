import 'package:flutter/material.dart';
import 'package:medicscape/LoadingFirstAid.dart';
import 'package:medicscape/reusablewidgets.dart';

class FirstAidBasicsMain extends StatefulWidget {
  const FirstAidBasicsMain({Key? key}) : super(key: key);

  @override
  State<FirstAidBasicsMain> createState() => _FirstAidBasicsMainState();
}

class _FirstAidBasicsMainState extends State<FirstAidBasicsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FirstAidBasicsMain")),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                FirstAidCards(
                    "Basics of First Aid",
                    MaterialPageRoute(
                      builder: (context) => LoadingFirstAid(
                        cardName: "FirstAidBasics",
                      ),
                    ),
                    context),
                FirstAidCards(
                    "Splint",
                    MaterialPageRoute(
                      builder: (context) => LoadingFirstAid(
                        cardName: "Splint",
                      ),
                    ),
                    context),
                FirstAidCards(
                    "First Aid Kit",
                    MaterialPageRoute(
                      builder: (context) => LoadingFirstAid(
                        cardName: "FirstAidKit",
                      ),
                    ),
                    context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
