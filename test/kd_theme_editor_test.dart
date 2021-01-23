import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kd_theme_editor/kd_theme_editor.dart';

void main() {
  group('ThemeProvider', () {
    testWidgets('should provide default theme', (tester) async {
      final primaryColor = Colors.deepPurple;
      final secondaryColor = Colors.cyanAccent;
      await tester.pumpWidget(ThemeProvider(
          theme: ThemeData.light()
              .withHighLights(primary: primaryColor, secondary: secondaryColor),
          child: Builder(builder: (context) {
            return MaterialApp(
                theme: ThemeManager.of(context).theme,
                home: Builder(builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      onPressed: () {},
                    ),
                  );
                }));
          })));
      await tester.pumpAndSettle();

      final appBar = tester.widget(find.byType(AppBar)) as AppBar;
      expect(appBar.backgroundColor, primaryColor);
      final fab = tester.widget(find.byType(FloatingActionButton))
          as FloatingActionButton;
      expect(fab.backgroundColor, secondaryColor);
    });
  });
}
