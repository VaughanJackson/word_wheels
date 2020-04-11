import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Wheel extends StatefulWidget {
  String _wheelKey;
  String _characters;

  // Callback for when a character is selected.
  ValueSetter<String> _onCharacterSelected;

  // Used for widget testing only (I think). Gives us a way to manipulate
  // the underlying ListWheelScrollView.
  // See https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/list_wheel_scroll_view_test.dart
  FixedExtentScrollController _testController;

  Wheel(this._wheelKey, this._characters, this._onCharacterSelected);

  Wheel.withTestController(final String wheelKey,
                           final String characters,
                           final ValueSetter<String> onCharacterSelected,
                           final FixedExtentScrollController testController) {
    this._wheelKey = wheelKey;
    this._characters = characters;
    this._onCharacterSelected = onCharacterSelected;
    this._testController = testController;
  }

  @override
  State<StatefulWidget> createState() => _WheelState();

}

class _WheelState extends State<Wheel> {

  @override
  Widget build(BuildContext context) {
    // TODO It seems buttons within scroll wheels do not work.
    // See https://github.com/flutter/flutter/issues/38803.
    final List<Widget> buttons = [];
    widget._characters.runes.forEach((int rune) {
      final character = new String.fromCharCode(rune);
      buttons.add(MaterialButton(
        key: Key('${widget._wheelKey}.$character'),
        child: Text(
          character,
          key: Key('${widget._wheelKey}.$character.text'),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ));
    });
    return Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoPicker(
      key: Key(widget._wheelKey),
      magnification: 1.5,
      backgroundColor: Colors.black87,
      children: buttons,
      scrollController: widget._testController,
      itemExtent: 50, //height of each item
      looping: false,
      onSelectedItemChanged: (int index) {
        final String selectedCharacter = widget._characters[index];
        print(selectedCharacter);
        widget._onCharacterSelected(selectedCharacter);
      },
    ));
  }
}