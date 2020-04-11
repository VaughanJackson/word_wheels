import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_wheels/wheel.dart';

class Wheels extends StatelessWidget {
  final List<String> characters;

  const Wheels(this.characters);

  @override
  Widget build(BuildContext context) {

    final List<Widget> wheels = [];
    int no = 1;
    characters.forEach((chars) {
      wheels.add(Expanded(
        // TODO Make callback do something useful
          child: Wheel('wheel$no', chars, (character) { print('>>>' + character); })
      ));
      no++;
    });
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
        key: Key('wheels'),
        child: Row(children: wheels)
    ));
  }
}
