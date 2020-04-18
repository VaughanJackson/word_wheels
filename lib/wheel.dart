import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import 'governor.dart';

class Wheel extends StatefulWidget {
  int _wheelIndex;
  String _wheelKey;
  String _characters;

  // Callback for when a character is selected.
  ValueSetter<Tuple2<int, String>> _onCharacterSelected;

  // Used for widget testing only (I think). Gives us a way to manipulate
  // the underlying ListWheelScrollView.
  // See https://github.com/flutter/flutter/blob/master/packages/flutter/test
  // /widgets/list_wheel_scroll_view_test.dart
  FixedExtentScrollController _testController;

  Wheel(this._wheelIndex,
        this._wheelKey,
        this._characters,
        this._onCharacterSelected);

  Wheel.withTestController(
      final int wheelIndex,
      final String wheelKey,
      final String characters,
      final ValueSetter<Tuple2<int, String>> onCharacterSelected,
      final FixedExtentScrollController testController) {
    this._wheelIndex = wheelIndex;
    this._wheelKey = wheelKey;
    this._characters = characters;
    this._onCharacterSelected = onCharacterSelected;
    this._testController = testController;
  }

  @override
  State<StatefulWidget> createState() => _WheelState();

}

class _WheelState extends State<Wheel> {
  Governor _governor;

  @override
  void initState() {
    _governor = new Governor(_onCharacterSelected);
    super.initState();
  }

  @override
  void dispose() {
    _governor.dispose();
    super.dispose();
  }

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
        print('_WheelState.onSelectedItemChanged(' + index.toString() +
            '): wheel ' + widget._wheelIndex.toString() + ' = ' +
            selectedCharacter);
//        final selection = Tuple2<int, String>(widget._wheelIndex, selectedCharacter);
//        widget._onCharacterSelected(selection);
        _governor.onCharacterSelected(selectedCharacter);
      },
    ));
  }

  void _onCharacterSelected(final String character) {
    print('_WheelState._onCharacterSelected(' + character + ')');
    final selection = Tuple2<int, String>(widget._wheelIndex, character);
    widget._onCharacterSelected(selection);
  }
}