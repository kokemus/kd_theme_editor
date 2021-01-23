import 'package:flutter/material.dart';

class ThemeProvider extends StatefulWidget {
  ThemeProvider({
    Key key,
    ThemeData theme,
    @required this.child,
    this.onChanged,
  })  : this.theme = theme ?? ThemeData().withHighLight(Colors.blue),
        super(key: key);

  final ThemeData theme;
  final Widget child;
  final Function(ThemeData theme) onChanged;

  @override
  State<StatefulWidget> createState() => ThemeManager();
}

class ThemeManager extends State<ThemeProvider> {
  @override
  void initState() {
    _theme = widget.theme;
    super.initState();
  }

  ThemeData _theme;

  ThemeData get theme => _theme;
  set theme(value) {
    setState(() {
      _theme = value;
    });
    if (widget.onChanged != null) {
      widget.onChanged(_theme);
    }
  }

  static ThemeManager of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ThemeManager>().state;

  @override
  Widget build(BuildContext context) => _ThemeManager(
        child: widget.child,
        state: this,
      );
}

class _ThemeManager extends InheritedWidget {
  _ThemeManager({
    Key key,
    @required this.state,
    @required Widget child,
  }) : super(key: key, child: child);

  final ThemeManager state;

  @override
  bool updateShouldNotify(_ThemeManager old) => true;
}

extension WithAccent on ThemeData {
  ThemeData withHighLight(Color color) {
    final onColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return this.copyWith(
      primaryColor: color,
      accentColor: color,
      toggleableActiveColor: color,
      primaryTextTheme: this.primaryTextTheme.apply(bodyColor: onColor),
      primaryIconTheme: this.primaryIconTheme.copyWith(color: onColor),
      colorScheme: this.colorScheme.copyWith(
          primary: color,
          onPrimary: onColor,
          secondary: color,
          onSecondary: onColor),
    );
  }

  ThemeData withHighLights(
      {@required Color primary, @required Color secondary}) {
    final onPrimaryColor =
        primary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    final onSecondaryColor =
        secondary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return this.copyWith(
      primaryColor: primary,
      accentColor: secondary,
      toggleableActiveColor: secondary,
      primaryTextTheme: this.primaryTextTheme.apply(bodyColor: onPrimaryColor),
      primaryIconTheme: this.primaryIconTheme.copyWith(color: onPrimaryColor),
      colorScheme: this.colorScheme.copyWith(
          primary: primary,
          onPrimary: onPrimaryColor,
          secondary: secondary,
          onSecondary: onSecondaryColor),
    );
  }
}
