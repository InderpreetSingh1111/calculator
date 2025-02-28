import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
              Row(
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("C"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "C",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () => buttonPressed("+/-"),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        padding: EdgeInsets.all(22),
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("^"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => buttonPressed("√"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          padding: EdgeInsets.all(30),
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
                  Expanded(
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
                  Expanded(
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
                              vertical: 25, horizontal: 80),
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
            ],
          ),
        ],
      ),
    );
  }
}
