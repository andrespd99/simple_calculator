import 'dart:async';

class KeyboardBloc {
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

  dispose() {
    _inputStreamController?.close();
    _resultStreamController?.close();
  }

  void pushDigit(String value) async {
    if (value == 'C')
      _eraseCalc();
    else if (value == 'DEL' || value == 'del') {
      if (this._inputOperand.length > 0) {
        this._inputOperand =
            this._inputOperand.substring(0, this._inputOperand.length - 1);
        await inputSink(this._inputOperand);
      }
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
    //_nextOperation saves the operator to be used.
    this._nextOperation = value;
    //_auxOperand saves the first operand with which the operation is to be made.
    this._auxOperand = _inputOperand;
    this._inputOperand = "";
    await inputSink("");
    print('ok' + value);
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
    double doubleOperand2;
    double doubleOperand1;
    double result = 0;

    if (_auxOperand.isEmpty) _auxOperand = '0';
    if (_inputOperand.isEmpty) _inputOperand = '0';

    if (_nextOperation.isNotEmpty) {
      switch (_nextOperation) {
        case '+':
          doubleOperand1 = double.parse(_auxOperand);
          doubleOperand2 = double.parse(_inputOperand);
          result = doubleOperand1 + doubleOperand2;
          break;
        case '-':
          doubleOperand1 = double.parse(_auxOperand);
          doubleOperand2 = double.parse(_inputOperand);
          result = doubleOperand1 - doubleOperand2;
          break;
        case '/':
          doubleOperand1 = double.parse(_auxOperand);
          doubleOperand2 = double.parse(_inputOperand);
          result = doubleOperand1 / doubleOperand2;
          break;
        case '×':
          doubleOperand1 = double.parse(_auxOperand);
          doubleOperand2 = double.parse(_inputOperand);
          result = doubleOperand1 * doubleOperand2;
          break;
      }
    }
    await this.resultSink(result.toString());
    this._inputOperand = result.toString();
  }
}
