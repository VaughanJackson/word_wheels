import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Wheel extends StatefulWidget {
  final String wheelKey;
  final String characters;

  const Wheel(this.wheelKey, this.characters);

  @override
  State<StatefulWidget> createState() => _WheelState();

}

class _WheelState extends State<Wheel> {
  int selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [];
    widget.characters.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      buttons.add(MaterialButton(
        key: Key('${widget.wheelKey}.$character'),
        child: Text(
          character,
          key: Key('${widget.wheelKey}.$character.text'),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ));
    });
    return Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoPicker(
      key: Key(widget.wheelKey),
      magnification: 1.5,
      backgroundColor: Colors.black87,
      children: buttons,
      itemExtent: 50, //height of each item
      looping: false,
      onSelectedItemChanged: (int index) {
        selectedItem = index;
      },
    ));
  }
}