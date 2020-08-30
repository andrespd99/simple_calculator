import 'dart:io';

import 'package:flutter/material.dart';

import 'package:simple_calculator/components/keyboard_layout.dart';

import 'package:simple_calculator/constants.dart';
import 'package:simple_calculator/services/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({this.title = 'title'});
  final String title;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        height: size.height,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: Divider(color: Colors.black)),
              //Widget that shows the value typed on keyboard
              InputValueBox(size: size),
              SizedBox(
                height: size.height * 0.05,
              ),
              //Widget that shows the result.
              OutputValueBox(size: size),
              SizedBox(height: size.height * 0.03),
              KeyboardLayout(size: size)
            ],
          ),
        ),
      ),
    );
  }
}

class InputValueBox extends StatelessWidget {
  InputValueBox({
    this.size,
  });

  Size size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of(context).inputStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx > 0 || details.delta.dx < 0) {
              Provider.of(context).swipeToErase();
            }
          },
          child: Container(
            padding: EdgeInsets.only(right: kDefaultPadding),
            width: double.infinity,
            height: size.height * 0.10,
            color: kPrimaryColor,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                snapshot.hasData
                    ? (snapshot.data.isNotEmpty ? snapshot.data : "")
                    : "",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 70.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class OutputValueBox extends StatelessWidget {
  OutputValueBox({
    Key key,
    this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of(context).resultStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Container(
          padding: EdgeInsets.only(right: kDefaultPadding),
          width: double.infinity,
          height: size.height * 0.125,
          color: kPrimaryColor,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              snapshot.hasData
                  ? (snapshot.data.isNotEmpty ? snapshot.data : "0")
                  : "0",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 100.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
