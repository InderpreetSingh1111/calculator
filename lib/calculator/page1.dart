import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String input = "";

  // String response = "";
  String output = "0";
  double num1 = 0;
  double num2 = 0;
  String operator = "";
  bool isResultDisplayed = true;

  String formatOutput(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(2);
    }
  }

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        output = "0";
        num1 = 0;
        num2 = 0;
        operator = "";
        isResultDisplayed = false;
      } else if (value == "+/-") {
        output = "-" + output.toString();
      } else if (value == "%") {
        output = formatOutput(double.parse(output) / 100);
      } else if (value == "=") {
        num2 = double.parse(output);
        if (operator == "+") {
          output = formatOutput(num1 + num2);
        } else if (operator == "-") {
          output = formatOutput(num1 - num2);
        } else if (operator == "×") {
          output = formatOutput(num1 * num2);
        } else if (operator == "÷") {
          output = formatOutput(num1 / num2);
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
      } else if (["+", "-", "×", "÷"].contains(value)) {
        num1 = double.parse(output);
        operator = value;
        input = "$output $value";
        output = "";
        isResultDisplayed = false;
      } else {
        output = output == "0" ? value : output + value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Column(

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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () => buttonPressed("!"),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.all(30),
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
            ],
          )
        ],
      ),
    );
  }
}
