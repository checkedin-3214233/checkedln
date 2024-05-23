import 'package:flutter/material.dart';

class CustomInfoPage extends StatelessWidget {
  final String icon;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback buttonTextOnTap;
  final bool showSecondButton;
  final String secondButtonText;
  final VoidCallback secondButtonOnTap;

  const CustomInfoPage({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.buttonTextOnTap,
    this.showSecondButton = false,
    this.secondButtonText = '',
    required this.secondButtonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              title,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: buttonTextOnTap,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
