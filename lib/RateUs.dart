import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class RateUs extends StatefulWidget {
  const RateUs({Key? key}) : super(key: key);

  @override
  State<RateUs> createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  void dispose() {
    super.dispose();
  }

  String rating = "3";
  List<String> stars = ["1", "2", "3", "4", "5"];

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController ratingController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Give your ratings",
              style: GoogleFonts.josefinSans(
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          TextField(
            obscureText: false,
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              labelText: "Enter your name:",
              prefixIcon: Icon(Icons.abc),
            ),
          ),
          TextField(
            obscureText: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              labelText: "Enter your mail ID:",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          Row(
            children: [
              Text(
                "Enter your rating:",
              ),
              DropdownButton(
                value: rating,
                dropdownColor: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: stars.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    var currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    rating = newValue as String;
                  });
                },
              ),
            ],
          ),
          TextField(
            obscureText: false,
            controller: messageController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              labelText: "Enter your message :",
              prefixIcon: Icon(Icons.abc),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          // ElevatedButton(
          //   onPressed: uploadImage,
          //   child: const Text("upload photo"),
          // ),
          GestureDetector(
            onTap: () async {
              CollectionReference helpers =
                  FirebaseFirestore.instance.collection("Feedback");

              await helpers
                  .add({
                    "name": nameController.text,
                    "email": emailController.text,
                    "message": messageController.text,
                    "rating": rating,
                  })
                  .then((value) =>
                      helpers.doc(value.id).update({"DocId": value.id}))
                  .then((value) => Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (route) => false));
            },
            child: Text("Send Rating"),
          ),
        ]),
      ),
    );
  }
}
