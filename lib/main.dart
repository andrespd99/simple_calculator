import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:simple_calculator/constants.dart';
import 'package:simple_calculator/services/provider.dart';
import 'package:simple_calculator/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Calculator',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          textTheme: GoogleFonts.latoTextTheme(theme.textTheme).apply(
            bodyColor: kTextColor,
          ),
        ),
        home: HomePage(title: kAppTitle),
      ),
    );
  }
}
