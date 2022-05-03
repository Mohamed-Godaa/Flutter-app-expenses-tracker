import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  errorColor: Colors.red,
  textTheme: ThemeData.light().textTheme.copyWith(
      headline6: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
      ),
      button: const TextStyle(color: Colors.white)),
  primarySwatch: Colors.purple,
  fontFamily: 'QuickSand',
  appBarTheme: AppBarTheme(
    toolbarTextStyle: ThemeData.light()
        .textTheme
        .copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        )
        .bodyText2,
    titleTextStyle: ThemeData.light()
        .textTheme
        .copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        )
        .headline6,
  ),
);
