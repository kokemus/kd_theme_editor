# kd_theme_editor

A Flutter plugin for editing application theme.

*Give user freedom to choose.*

## Usage

```
dependencies:
  kd_theme_editor:
    git:
      url: git://github.com/kokemus/kd_theme_editor.git

```

### Example

``` dart
import 'package:kd_theme_editor/kd_theme_editor.dart';

final _lightColors = [Colors.blue, Colors.red, Colors.green];
final _darkColors = [Colors.blueAccent, Colors.redAccent, Colors.greenAccent];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      // Default theme      
      theme: ThemeData().withHighLight(_lightColors.first),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          // Current theme
          theme: ThemeManager.of(context).theme,
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }),
    );
  }
}

...
  IconButton(
      icon: Icon(Icons.color_lens),
      onPressed: () => showThemeEditor(context,
          lightColors: _lightColors, darkColors: _darkColors))
...
```

## Screenshots

<img src="https://github.com/kokemus/kd_theme_editor/blob/master/screenshots/editor_simple_light.png?raw=true" alt="Editor simple light" width="250">
<img src="https://github.com/kokemus/kd_theme_editor/blob/master/screenshots/editor_advanced_light.png?raw=true" alt="Editor advanced light" width="250">
<img src="https://github.com/kokemus/kd_theme_editor/blob/master/screenshots/editor_simple_dark.png?raw=true" alt="Editor simple dark" width="250">
<img src="https://github.com/kokemus/kd_theme_editor/blob/master/screenshots/editor_advanced_dark.png?raw=true" alt="Editor advanced dark" width="250">