import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  String input = "";
  String output = "0";
  double num1 = 0;
  double num2 = 0;
  String operator = "";
  bool isResultDisplayed = true;
  bool hideSpecialButtons = false;

  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _sizeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void buttonPressed(String value) {
    setState(() {
      if (value == "hide") {
        hideSpecialButtons = !hideSpecialButtons;
        if (hideSpecialButtons) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      } else if (value == "C") {
        input = "";
        output = "0";
        num1 = 0;
        num2 = 0;
        operator = "";
        isResultDisplayed = false;
      } else if (value == "+/-") {
        output = "-" + output.toString();
      } else if (value == "%") {
        output = (double.parse(output) / 100).toString();
      } else if (value == "=") {
        num2 = double.parse(output);
        if (operator == "+") {
          output = (num1 + num2).toString();
        } else if (operator == "-") {
          output = (num1 - num2).toString();
        } else if (operator == "×") {
          output = (num1 * num2).toString();
        } else if (operator == "÷") {
          output = (num1 / num2).toString();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display Output
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
                      fontWeight: isResultDisplayed ? FontWeight.normal : FontWeight.bold,
                      color: Colors.white70),
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: 80,
                      fontWeight: isResultDisplayed ? FontWeight.bold : FontWeight.normal,
                      color: Colors.white),
                ),
              ],
            ),
          ),

          // Button Grid
          Expanded(
            flex: hideSpecialButtons ? 5 : 6, // Adjusts space dynamically
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizeTransition(
                        sizeFactor: _sizeAnimation,
                        axis: Axis.vertical,
                        child: AnimatedOpacity(
                          opacity: hideSpecialButtons ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 500),
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
                    ),
                    Expanded(
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
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => buttonPressed("+/-"),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(30),
                          alignment: Alignment.center,
                          child: Text(
                            "+/-",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
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
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Number and Operator Buttons
                for (var row in [
                  ["7", "8", "9", "÷"],
                  ["4", "5", "6", "×"],
                  ["1", "2", "3", "-"],
                  ["0", ".", "=", "+"]
                ])
                  Row(
                    children: row.map((value) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => buttonPressed(value),
                          child: Container(
                            margin: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              shape: value == "0" ? BoxShape.rectangle : BoxShape.circle,
                              borderRadius: value == "0" ? BorderRadius.circular(50) : null,
                              color: value == "=" || value == "+" || value == "-" || value == "×" || value == "÷"
                                  ? Colors.orange
                                  : Colors.grey.shade800,
                            ),
                            padding: EdgeInsets.all(30),
                            alignment: Alignment.center,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
