import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => const CalculatorPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [CupertinoColors.systemBlue, CupertinoColors.systemTeal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(CupertinoIcons.circle_grid_3x3_fill,
                  size: 100, color: CupertinoColors.white),
              SizedBox(height: 20),
              Text(
                "Calculator App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _currentInput = "";
  String _operator = "";
  double _firstOperand = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _operator = "";
        _firstOperand = 0;
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        _operator = buttonText;
        _firstOperand = double.parse(_currentInput);
        _currentInput = "";
      } else if (buttonText == "=") {
        double secondOperand = double.parse(_currentInput);
        if (_operator == "+") {
          _output = (_firstOperand + secondOperand).toString();
        } else if (_operator == "-") {
          _output = (_firstOperand - secondOperand).toString();
        } else if (_operator == "×") {
          _output = (_firstOperand * secondOperand).toString();
        } else if (_operator == "÷") {
          _output = secondOperand != 0 ? (_firstOperand / secondOperand).toString() : "Error";
        }
        _currentInput = _output;
        _operator = "";
      } else {
        _currentInput += buttonText;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String text,
      {Color color = CupertinoColors.systemGrey, double size = 70}) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _buttonPressed(text),
      child: Container(
        height: size,
        width: size,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [CupertinoColors.systemGrey6, CupertinoColors.systemGrey4],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display Screen
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 100,
                  child: Text(
                    _output,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
                const Divider(),
                // Buttons
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton("7"),
                        _buildButton("8"),
                        _buildButton("9"),
                        _buildButton("÷", color: CupertinoColors.systemOrange),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton("4"),
                        _buildButton("5"),
                        _buildButton("6"),
                        _buildButton("×", color: CupertinoColors.systemOrange),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton("1"),
                        _buildButton("2"),
                        _buildButton("3"),
                        _buildButton("-", color: CupertinoColors.systemOrange),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton("C", color: const Color.fromARGB(255, 54, 54, 54)),
                        _buildButton("0"),
                        _buildButton("=", color: CupertinoColors.systemOrange),
                        _buildButton("+", color: CupertinoColors.systemOrange),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
