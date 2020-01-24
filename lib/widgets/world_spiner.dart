import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class WorldSinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: FlareActor(
            "assets/WorldSpin.flr",
            fit: BoxFit.contain,
            animation: "roll",
          ),
          height: 300,
          width: 300,
        ));
  }
}