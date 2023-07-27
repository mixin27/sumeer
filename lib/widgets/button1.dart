import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  const Button1({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF407BFF),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            ClipOval(
              child: SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
