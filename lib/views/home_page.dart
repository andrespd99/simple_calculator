import 'package:flutter/material.dart';
import 'package:simple_calculator/constants.dart';

class HomePage extends StatelessWidget {
  String title;

  HomePage(String title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final Size size = mq.size;
    final double paddingSize = mq.padding.top + mq.padding.bottom;
    final Size safeSize = new Size(size.width, size.height - paddingSize);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      //   backgroundColor: kPrimaryColor,
      // ),
      body: Container(
        color: kPrimaryColor,
        height: size.height,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: Divider()),
              Row(
                children: [
                  Container(
                    width: size.width * 0.75,
                    child: Table(
                      border: TableBorder.all(color: kPrimaryColor, width: 2.0),
                      children: [
                        TableRow(
                          children: [
                            CalculatorButton('C'),
                            CalculatorButton('DEL'),
                            CalculatorButton('%'),
                          ],
                        ),
                        TableRow(
                          children: [
                            CalculatorButton('7'),
                            CalculatorButton('8'),
                            CalculatorButton('9'),
                          ],
                        ),
                        TableRow(
                          children: [
                            CalculatorButton('4'),
                            CalculatorButton('5'),
                            CalculatorButton('6'),
                          ],
                        ),
                        TableRow(
                          children: [
                            CalculatorButton('1'),
                            CalculatorButton('2'),
                            CalculatorButton('3'),
                          ],
                        ),
                        TableRow(
                          children: [
                            CalculatorButton(''),
                            CalculatorButton('0'),
                            CalculatorButton('00'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.25,
                    child: Table(
                      border: TableBorder(
                        horizontalInside:
                            BorderSide(color: kPrimaryColor, width: 2.0),
                        top: BorderSide(color: kPrimaryColor, width: 2.0),
                        bottom: BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      children: [
                        TableRow(
                          children: [CalculatorButton('×', color: Colors.blue)],
                        ),
                        TableRow(
                          children: [CalculatorButton('+', color: Colors.blue)],
                        ),
                        TableRow(
                          children: [CalculatorButton('-', color: Colors.blue)],
                        ),
                        TableRow(
                          children: [
                            CalculatorButton(
                              '=',
                              buttonHeight: 2,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  double buttonHeight;
  Color color;

  CalculatorButton(
    this.char, {
    Key key,
    this.buttonHeight = 1,
    this.color = Colors.grey,
  }) : super(key: key);

  final String char;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * this.buttonHeight,
      child: FlatButton(
        color: this.color,
        onPressed: () {},
        child: Center(
          child: Text(char, style: TextStyle(fontSize: 20.0)),
        ),
      ),
    );
  }
}
