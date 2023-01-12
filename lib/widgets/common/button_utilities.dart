import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockolio/helpers/definitions.dart';

class ButtonUltilities extends StatelessWidget {
  final String buttonCommand;
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoadingButton;
  final FaIcon? iconData;
  final GestureTapCallback onButtonPressed;

  ButtonUltilities({
    required this.buttonCommand,
    required this.buttonText,
    required this.backgroundColor,
    required this.textColor,
    required this.isLoadingButton,
    required this.onButtonPressed,
    this.iconData,
  });

  @override
  // State<StatefulWidget> createState() => _ButtonUltilitiesState();

  @override
  Widget build(BuildContext context) {
    switch (buttonCommand) {
      case ButtonCommand.TEXT_BUTTON:
        return _buildTextButton(buttonText, backgroundColor, textColor,
            isLoadingButton, onButtonPressed);
      case ButtonCommand.OUTLINEED_BUTTON:
        return _buildOutlinedButton(buttonText, backgroundColor, textColor,
            isLoadingButton, onButtonPressed);
      default:
        return _buildTextButton(buttonText, backgroundColor, textColor,
            isLoadingButton, onButtonPressed);
    }
  }
}

Widget _buildTextButton(String text, Color bgColor, Color textColor,
    bool isLoadingButton, GestureTapCallback onPressed) {
  return Expanded(
    child: TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: bgColor,
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ignore: unused_element
Widget _buildTextButtonIcon(String text, Color bgColor, Color textColor,
    bool isLoadingButton, GestureTapCallback onPressed) {
  return Expanded(
    child: TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: bgColor,
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildOutlinedButton(String text, Color bgColor, Color textColor,
    bool isLoadingButton, GestureTapCallback onPressed) {
  return Expanded(
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        backgroundColor: bgColor,
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
