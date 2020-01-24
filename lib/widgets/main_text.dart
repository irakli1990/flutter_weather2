import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
          text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: 'Check '),
                TextSpan(
                    text: 'Weather ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'in any place of '),
                TextSpan(
                    text: 'World', style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
        ));
  }
}