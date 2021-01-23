import 'package:flutter/material.dart';

import 'color_picker.dart';
import 'theme_manager.dart';

const _lightColors = [Colors.blue, Colors.red, Colors.green, Colors.orange];
const _darkColors = [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
  Colors.orangeAccent
];

showThemeEditor(
  BuildContext context, {
  List<Color> lightColors,
  List<Color> darkColors,
}) async {
  return showModalBottomSheet(
      context: context,
      builder: (_) => ThemeEditor(
            lightColors: lightColors ?? _lightColors,
            darkColors: darkColors ?? _darkColors,
          ));
}

class ThemeEditor extends StatefulWidget {
  const ThemeEditor({
    Key key,
    this.lightColors,
    this.darkColors,
  }) : super(key: key);

  final List<Color> lightColors;
  final List<Color> darkColors;

  @override
  State<StatefulWidget> createState() => _ThemeEditorState();
}

class _ThemeEditorState extends State<ThemeEditor> {
  Color _primaryColor;
  Color _secondaryColor;
  bool _showAdvanced = false;

  @override
  void didChangeDependencies() {
    final manager = ThemeManager.of(context);
    final colors = manager.theme.brightness == Brightness.dark
        ? widget.darkColors
        : widget.lightColors;
    _primaryColor = manager.theme.primaryColor;
    _secondaryColor = manager.theme.colorScheme.secondary;

    if (!colors.contains(_primaryColor) || !colors.contains(_secondaryColor)) {
      _showAdvanced = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ThemeManager.of(context);

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text('Appereance',
                      style: Theme.of(context).textTheme.headline6)),
              Column(children: [
                RadioListTile<Brightness>(
                  title: Text('Light'),
                  value: Brightness.light,
                  groupValue: manager.theme.brightness,
                  onChanged: (value) {
                    manager.theme = ThemeData.light()
                        .withHighLight(widget.lightColors.first);
                  },
                ),
                RadioListTile<Brightness>(
                  title: Text('Dark'),
                  value: Brightness.dark,
                  groupValue: manager.theme.brightness,
                  onChanged: (value) {
                    manager.theme =
                        ThemeData.dark().withHighLight(widget.darkColors.first);
                  },
                ),
              ]),
              if (!_showAdvanced)
                _buildBasic(context, manager)
              else
                _buildAdvanced(context, manager),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasic(BuildContext context, ThemeManager manager) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(8.0),
            child: Text('Highlight color',
                style: Theme.of(context).textTheme.headline6)),
        Container(
          margin: EdgeInsets.all(16),
          child: Wrap(
            spacing: 32,
            children: [
              for (final color in manager.theme.brightness == Brightness.dark
                  ? widget.darkColors
                  : widget.lightColors)
                FloatingActionButton(
                    child: manager.theme.primaryColor == color
                        ? Icon(Icons.check)
                        : null,
                    mini: true,
                    backgroundColor: color,
                    onPressed: () {
                      manager.theme =
                          ThemeData(brightness: manager.theme.brightness)
                              .withHighLight(color);
                    }),
            ],
          ),
        ),
        ExpansionTile(
          tilePadding: EdgeInsets.all(8),
          title: Text('Advanced', style: Theme.of(context).textTheme.headline6),
          onExpansionChanged: (value) {
            setState(() {
              _showAdvanced = true;
            });
          },
        )
      ],
    );
  }

  Widget _buildAdvanced(BuildContext context, ThemeManager manager) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(8.0),
            child: Text('Primary color',
                style: Theme.of(context).textTheme.headline6)),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16),
              child: FloatingActionButton(
                  child: manager.theme.primaryColor == _primaryColor
                      ? Icon(Icons.check)
                      : null,
                  mini: true,
                  backgroundColor: _primaryColor,
                  onPressed: () {
                    manager.theme =
                        ThemeData(brightness: manager.theme.brightness)
                            .withHighLights(
                                primary: _primaryColor,
                                secondary: manager.theme.colorScheme.secondary);
                  }),
            ),
            Expanded(
              child: ColorPicker(
                  onChanged: (value) {
                    setState(() {
                      _primaryColor = value;
                    });
                  },
                  color: _primaryColor),
            )
          ],
        ),
        Container(
            margin: const EdgeInsets.all(8.0),
            child: Text('Secondary color',
                style: Theme.of(context).textTheme.headline6)),
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 16),
                child: FloatingActionButton(
                    child:
                        manager.theme.colorScheme.secondary == _secondaryColor
                            ? Icon(Icons.check)
                            : null,
                    backgroundColor: _secondaryColor,
                    mini: true,
                    onPressed: () {
                      manager.theme =
                          ThemeData(brightness: manager.theme.brightness)
                              .withHighLights(
                                  primary: manager.theme.colorScheme.primary,
                                  secondary: _secondaryColor);
                    })),
            Expanded(
              child: ColorPicker(
                  onChanged: (value) {
                    setState(() {
                      _secondaryColor = value;
                    });
                  },
                  color: _secondaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
