import 'dart:math';

import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  String input = "";

  String output = "0";
  double num1 = 0;
  double num2 = 0;
  String operator = "";
  bool isResultDisplayed = true;
  bool hideSpecialButtons = false;
  bool hasInput = false;

  String formatOutput(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(2);
    }
  }

  void buttonPressed(String value) {
    setState(() {
      print(value);
      if (value == "hide") {
        hideSpecialButtons = !hideSpecialButtons;
      }else if (value == "Back") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
          output = input.isEmpty ? "0" : input;
        }
        hasInput = input.isNotEmpty;
      }
      else if (value == "C") {
        input = "";
        output = "0";
        num1 = 0;
        num2 = 0;
        operator = "";
        isResultDisplayed = false;
      }
      else if (value == "+/-") {
        output = (double.parse(output) * -1).toString();
      }
      else if (value == "%") {
        if (operator.isEmpty) {
          num1 = double.parse(output);
          operator = "%";
          input = "$output %";
          output = "";
        }
        hasInput = true;
      }
      else if (value == "π") {
        output = formatOutput(pi);
      }
      else if (value == "√") {
        output = formatOutput(sqrt(double.parse(output)));
      }
      else if (value == "!") {
        int num = int.tryParse(output) ?? 0;
        int fact = 1;
        for (int i = 1; i <= num; i++) {
          fact *= i;
        }
        output = fact.toString();
      }
      else if (value == "^") {
        num1 = double.parse(output);
        operator = "^";
        input = "$output ^";
        output = "";
        isResultDisplayed = false;
      }
      else if (value == "=") {
        num2 = double.tryParse(output) ?? 0;
        if (operator == "%") {
          output = formatOutput((num1 / num2) * 100);{
            if (num1 > num2){
              output = "error";
        }
          }
        }if (operator == "+") {
          output = formatOutput(num1 + num2);
        } else if (operator == "-") {
          output = formatOutput(num1 - num2);
        } else if (operator == "×") {
          output = formatOutput(num1 * num2);
        } else if (operator == "÷") {
          output = num2 == 0 ? "Error" : formatOutput(num1 / num2);
        } else if (operator == "^") {
          output = formatOutput(pow(num1, num2).toDouble());
        }

        if (num1.toString().endsWith(".0") && num2.toString().endsWith(".0")) {
          input = "${num1.toInt()} $operator ${num2.toInt()}";
        } else if (num1.toString().endsWith(".0") ||
            num2.toString().endsWith(".0")) {
          if (num1.toString().endsWith(".0")) {
            input = "${num1.toInt()} $operator ${num2}";
          } else if (num2.toString().endsWith(".0")) {
            input = "${num1} $operator ${num2.toInt()}";
          } else {
            input = "${num1} $operator ${num2}";
          }
        }
        num1 = 0;
        num2 = 0;
        operator = "";
        isResultDisplayed = true;
        hasInput = false;
      }
      else if (value.toString() == "e") {
        output = formatOutput(2.71);
        print(output);
      }
      else if (["+", "-", "×", "÷"].contains(value)) {
        num1 = double.parse(output);
        operator = value;
        input = "$output $value";
        output = "";
        isResultDisplayed = false;
      }
      else {
        output = output == "0" ? value : output + value;
        input += value;
        hasInput = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => buttonPressed("hide"),
              child: Icon(
                Icons.calculate,
                color: Colors.white,
                size: 45,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: isResultDisplayed
                          ? FontWeight.normal
                          : FontWeight.bold,
                      color: Colors.white70),
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: 80,
                      fontWeight: isResultDisplayed
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  AnimatedOpacity(
                    opacity: hideSpecialButtons ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: hideSpecialButtons
                        ? SizedBox.shrink()
                        : Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () => buttonPressed("!"),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  padding: EdgeInsets.all(35),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "!",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed(hasInput ? "Back" : "C"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            hasInput ? "C" : "AC",
                            style: TextStyle(color: Colors.black,fontSize: hasInput? 30 : 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("+/-"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          child: Text(
                            "+/-",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("%"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "%",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("÷"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "÷",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AnimatedOpacity(
                    opacity: hideSpecialButtons ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: hideSpecialButtons
                        ? SizedBox.shrink()
                        : Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () => buttonPressed("^"),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade800,
                                  ),
                                  padding: EdgeInsets.all(35),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "^",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("7"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "7",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("8"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "8",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("9"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "9",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("×"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "×",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AnimatedOpacity(
                    opacity: hideSpecialButtons ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: hideSpecialButtons
                        ? SizedBox.shrink()
                        : Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () => buttonPressed("√"),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade800,
                                  ),
                                  padding: EdgeInsets.all(32),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "√",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("4"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "4",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("5"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "5",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("6"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "6",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("-"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "-",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AnimatedOpacity(
                    opacity: hideSpecialButtons ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: hideSpecialButtons
                        ? SizedBox.shrink()
                        : Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () => buttonPressed("π"),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade800,
                                  ),
                                  padding: EdgeInsets.all(30),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "π",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("1"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "1",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("2"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "2",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("3"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "3",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("+"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "+",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AnimatedOpacity(
                    opacity: hideSpecialButtons ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: hideSpecialButtons
                        ? SizedBox.shrink()
                        : Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () => buttonPressed("e"),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade800,
                                  ),
                                  padding: EdgeInsets.all(30),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "e",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("0"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 80),
                          alignment: Alignment.center,
                          child: Text(
                            "0",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("."),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            ".",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("="),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "=",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // ... (remaining rows of buttons)
            ],
          ),
        ],
      ),
    );
  }
}
