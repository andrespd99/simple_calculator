import 'package:flutter/material.dart';

import 'package:simple_calculator/components/keyboard_layout.dart';

import 'package:simple_calculator/constants.dart';
import 'package:simple_calculator/services/provider.dart';

class HomePage extends StatelessWidget {
  String title;

  HomePage(String title) {
    this.title = title;
  }

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
              InputValueBox(),
              SizedBox(
                height: size.height * 0.05,
              ),
              //Widget that shows the result.
              OutputValueBox(),
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of(context).inputStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Container(
          padding: EdgeInsets.only(right: kDefaultPadding),
          width: double.infinity,
          color: kPrimaryColor,
          child: Text(
            snapshot.hasData
                ? (snapshot.data.isNotEmpty ? snapshot.data : "0")
                : "0",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 70.0,
            ),
          ),
        );
      },
    );
  }
}

class OutputValueBox extends StatelessWidget {
  const OutputValueBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of(context).resultStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Container(
          padding: EdgeInsets.only(right: kDefaultPadding),
          width: double.infinity,
          color: kPrimaryColor,
          child: Text(
            snapshot.hasData
                ? (snapshot.data.isNotEmpty ? snapshot.data : "0")
                : "0",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 100.0,
            ),
          ),
        );
      },
    );
  }
}
