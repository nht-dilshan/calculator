import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = "0";
  double num1 = 0;
  double num2 = 0;
  String operation = '';
  bool isSecondNumber = false;

  // Function to handle button presses
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        // Clear everything
        displayText = "0";
        num1 = 0;
        num2 = 0;
        operation = '';
        isSecondNumber = false;
      } else if (buttonText == "+/-") {
        // Change sign
        displayText = (double.parse(displayText) * -1).toString();
      } else if (buttonText == "%") {
        // Percentage
        displayText = (double.parse(displayText) / 100).toString();
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
        // Set operation
        num1 = double.parse(displayText);
        operation = buttonText;
        isSecondNumber = true;
        displayText = "0";
      } else if (buttonText == "=") {
        // Perform calculation
        num2 = double.parse(displayText);
        switch (operation) {
          case "+":
            displayText = (num1 + num2).toString();
            break;
          case "-":
            displayText = (num1 - num2).toString();
            break;
          case "x":
            displayText = (num1 * num2).toString();
            break;
          case "/":
            displayText = (num2 != 0) ? (num1 / num2).toString() : "Error";
            break;
        }
        // Reset for next calculation
        num1 = 0;
        num2 = 0;
        operation = '';
        isSecondNumber = false;
      } else {
        // Handle numbers and decimal
        if (displayText == "0" || isSecondNumber) {
          displayText = buttonText;
          isSecondNumber = false;
        } else {
          displayText += buttonText;
        }
      }
    });
  }

  // Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color textcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () => buttonPressed(btntxt),
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 35,
            color: textcolor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          backgroundColor: btncolor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),

        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Calculator display
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(10.0),
              child: Text(
                displayText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Button rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('AC', Colors.grey[850]!, Colors.black),
                calcbutton('+/-', Colors.grey[850]!, Colors.black),
                calcbutton('%', Colors.grey[850]!, Colors.black),
                calcbutton('/', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('7', Colors.grey[850]!, Colors.black),
                calcbutton('8', Colors.grey[850]!, Colors.black),
                calcbutton('9', Colors.grey[850]!, Colors.black),
                calcbutton('x', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('4', Colors.grey[850]!, Colors.black),
                calcbutton('5', Colors.grey[850]!, Colors.black),
                calcbutton('6', Colors.grey[850]!, Colors.black),
                calcbutton('-', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('1', Colors.grey[850]!, Colors.black),
                calcbutton('2', Colors.grey[850]!, Colors.black),
                calcbutton('3', Colors.grey[850]!, Colors.black),
                calcbutton('+', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => buttonPressed("0"),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    backgroundColor: Colors.grey[850],
                  ),
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                calcbutton('.', Colors.grey[850]!, Colors.black),
                calcbutton('=', Colors.amber[700]!, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
