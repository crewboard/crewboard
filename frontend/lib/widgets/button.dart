import 'package:flutter/material.dart';

import '../globals.dart';


class SignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isActive;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const SignInButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isActive = true,
    this.text = 'Sign In',
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      label: text,
      onPress: (){},
    );
  }
}

class SignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isActive;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const SignUpButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isActive = true,
    this.text = 'Sign Up',
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      label: text,
      onPress: (){},
      // isLoading: isLoading,
      // isActive: isActive,
      // backgroundColor: backgroundColor ?? Colors.green,
      // foregroundColor: foregroundColor ?? Colors.white,
    );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        minimumSize: Size(30, 30),
      ),
      onPressed: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(color: Pallet.font3, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Button extends StatelessWidget {
  const Button({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          minimumSize: Size(30, 30),
        ),
        onPressed: () {
          onPress();
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Pallet.inside1, border: Border.all(color: Pallet.font3), borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Pallet.font3),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.add,
                color: Pallet.font3,
                size: 18,
              )
            ],
          )),
        ));
  }
}
