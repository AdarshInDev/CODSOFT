import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 68,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: buttonList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: const Color.fromARGB(255, 38, 163, 221),
      splashFactory: InkRipple.splashFactory,
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 7, 53, 133),
          color: getbgcolor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 230, 231, 235).withOpacity(0.15),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: const Offset(-3, -3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              // color: Color.fromARGB(255, 77, 139, 227),
              color: getcolor(text),
            ),
          ),
        ),
      ),
    );
  }

  getcolor(String text) {
    if (text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == 'C' ||
        text == 'AC' ||
        text == '' ||
        text == ')' ||
        text == '(') {
      return const Color.fromARGB(255, 51, 205, 4);
    }
    return const Color.fromARGB(255, 132, 143, 144);
  }

  getbgcolor(String text) {
    if (text == 'AC') {
      return const Color.fromARGB(255, 206, 74, 38);
    }
    if (text == '=') {
      return const Color.fromARGB(109, 6, 213, 9);
    }
    return const Color.fromARGB(255, 12, 36, 48);
  }

  handleButtons(String text) {
    if (text == 'AC') {
      userInput = "";
      text = "";
      result = "0";
    }
    if (text == 'C') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      result = calculate();
      userInput = result;

      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
        return;
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    } else {
      userInput = userInput + text;
    }
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "error";
    }
  }
}
