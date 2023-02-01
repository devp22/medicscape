import 'package:flutter/material.dart';

class Splint extends StatefulWidget {
  const Splint({Key? key}) : super(key: key);

  @override
  State<Splint> createState() => _SplintState();
}

class _SplintState extends State<Splint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Splint")),
    );
  }
}
