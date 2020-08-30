import 'dart:async';

class KeyboardBloc {
  //Stream controllers of input and result widgets.
  final _inputStreamController = StreamController<String>.broadcast();
  final _resultStreamController = StreamController<String>.broadcast();

  //Getters of stream and Sink of the stream controllers.
  Stream<String> get inputStream => _inputStreamController.stream;
  Function(String) get inputSink => _inputStreamController.add;
  Stream<String> get resultStream => _resultStreamController.stream;
  Function(String) get resultSink => _resultStreamController.add;

  String _inputOperand = ""; //Input operand value.
  String _auxOperand = ""; //First operand cached for math operation.

  //List of mathematical operators.
  List _operationsList = List.unmodifiable(['+', '-', '/', '×']);

  String _nextOperation = ""; //Next operation to be executed.

  bool swippable = true; //Swipper control.

  dispose() {
    _inputStreamController?.close();
    _resultStreamController?.close();
  }

  //Input listener.
  void pushDigit(String value) {
    //If Clear is hit, erase calculator data.
    if (value == 'C')
      _eraseCalc();
    else if (value == 'DEL' || value == 'del') {
      deleteDigit();
    } else if (_operationsList.contains(value)) {
      _preOperate(value);
    } else if (value == '=') {
      _calculate();
    } else {
      inputDigit(value);
    }
  }

  //Saves the operator selected and the value of the first operand.
  void _preOperate(String value) {
    //If both operands were defined and next input is another operator,
    //calculate result with last operator.
    if (this._nextOperation.isNotEmpty && this._auxOperand.isNotEmpty)
      _calculate();
    //_nextOperation saves the operator to be used next.
    this._nextOperation = value;
    if (value == '+' || value == '-') resultSink(this._inputOperand);
    //_auxOperand saves the first operand with which the operation is to be made.
    this._auxOperand = _inputOperand;
    this._inputOperand = "";
    // inputSink("");
  }

  //Delete calculator data
  void _eraseCalc() {
    this._inputOperand = "";
    this._auxOperand = "";
    this._nextOperation = "";
    inputSink("");
    resultSink("");
  }

  //Makes calculation.
  void _calculate() {
    num doubleOperand2;
    num doubleOperand1;
    num result = 0;

    if (_auxOperand.isEmpty) _auxOperand = '0';
    if (_inputOperand.isEmpty) _inputOperand = '0';

    if (_nextOperation.isNotEmpty) {
      doubleOperand1 = num.parse(_auxOperand);
      doubleOperand2 = num.parse(_inputOperand);
      switch (_nextOperation) {
        case '+':
          result = doubleOperand1 + doubleOperand2;
          break;
        case '-':
          result = doubleOperand1 - doubleOperand2;
          break;
        case '/':
          result = doubleOperand1 / doubleOperand2;
          break;
        case '×':
          result = doubleOperand1 * doubleOperand2;
          break;
      }
      this.resultSink(result.toString());
      this._inputOperand = result.toString();
      this._auxOperand = "";
    } else {
      this.resultSink(_inputOperand);
      this._inputOperand = "";
    }
  }

  void deleteDigit() {
    if (this._inputOperand.length > 0) {
      this._inputOperand =
          this._inputOperand.substring(0, this._inputOperand.length - 1);
      inputSink(this._inputOperand);
    }
  }

  void swipeToErase() {
    if (swippable) {
      print('qlq');
      this.swippable = false;
      deleteDigit();
      Timer(Duration(milliseconds: 500), () => (swippable = true));
    }
  }

  void inputDigit(String digit) {
    if (digit == ".") {
      if (this._inputOperand.isEmpty) {
        this._inputOperand = "0.";
      } else if (this._inputOperand.contains(".")) {
        //DO NOTHING IF DIGIT HAS DECIMAL SEPARATOR ALREADY.
      } else {
        this._inputOperand += digit;
      }
    } else if (digit.contains('0')) {
      if (this._inputOperand.isEmpty) {
        this._inputOperand += "0";
      } else if (this._inputOperand == '0') {
        //Do nothing if input operand is 0 and other 0 is hit again
        //to avoid multiple leading zeroes.
      } else {
        this._inputOperand += digit;
      }
    } else {
      this._inputOperand += digit;
    }
    inputSink(this._inputOperand);
  }
}
