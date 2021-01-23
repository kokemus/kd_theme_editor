import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    Key key,
    @required Function(Color color) onChanged,
    @required Color color,
  })  : _onChanged = onChanged,
        _color = color,
        super(key: key);

  final Function(Color color) _onChanged;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Slider(
              value: _color.red.toDouble(),
              activeColor: Color(0xFFFF0000),
              min: 0,
              max: 255,
              divisions: 255,
              label: _color.red.toString(),
              onChanged: (double value) {
                _onChanged(Color.fromARGB(255, value.round(),
                    _color.green.round(), _color.blue.round()));
              },
            ),
          ),
          Expanded(
            child: Slider(
              value: _color.green.toDouble(),
              activeColor: Color(0xFF00FF00),
              min: 0,
              max: 255,
              divisions: 255,
              label: _color.green.round().toString(),
              onChanged: (double value) {
                _onChanged(Color.fromARGB(255, _color.red.round(),
                    value.round(), _color.blue.round()));
              },
            ),
          ),
          Expanded(
            child: Slider(
              value: _color.blue.toDouble(),
              activeColor: Color(0xFF0000FF),
              min: 0,
              max: 255,
              divisions: 255,
              label: _color.blue.round().toString(),
              onChanged: (double value) {
                _onChanged(Color.fromARGB(
                  255,
                  _color.red.round(),
                  _color.green.round(),
                  value.round(),
                ));
              },
            ),
          )
        ],
      ),
    );
  }
}
