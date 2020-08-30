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

  bool swippable = true;

  dispose() {
    _inputStreamController?.close();
    _resultStreamController?.close();
  }

  void pushDigit(String value) async {
    if (value == 'C')
      _eraseCalc();
    else if (value == 'DEL' || value == 'del') {
      deleteDigit();
    } else if (_operationsList.contains(value)) {
      _preOperate(value);
    } else if (value == '=') {
      _calculate();
    } else {
      this._inputOperand += value;
      await inputSink(this._inputOperand);
    }
  }

  //Saves the operator selected and the value of the first operand.
  void _preOperate(String value) async {
    //If both operands were defined, calculate its result.
    if (this._inputOperand.isNotEmpty && this._auxOperand.isNotEmpty)
      _calculate();
    //_nextOperation saves the operator to be used next.
    this._nextOperation = value;
    if (value == '+' || value == '-') resultSink(this._inputOperand);
    //_auxOperand saves the first operand with which the operation is to be made.
    this._auxOperand = _inputOperand;
    this._inputOperand = "";
    // await inputSink("");
  }

  void _eraseCalc() async {
    this._inputOperand = "";
    this._auxOperand = "";
    this._nextOperation = "";
    await inputSink("");
    await resultSink("");
  }

  //Makes calculation.
  void _calculate() async {
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
}
