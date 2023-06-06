import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class animationtry extends StatefulWidget {
  const animationtry({Key? key}) : super(key: key);

  @override
  State<animationtry> createState() => _animationtryState();
}

class _animationtryState extends State<animationtry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset("assets/RiveAssets/harsh_animation.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 10),
              child: SizedBox(),
            ),
          ),
          Text(
            "data",
            style: TextStyle(fontSize: 100),
          ),
        ],
      ),
    );
  }
}
