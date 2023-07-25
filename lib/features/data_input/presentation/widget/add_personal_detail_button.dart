import 'package:flutter/material.dart';

class AddPersonalDetailButton extends StatelessWidget {
  const AddPersonalDetailButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const ClipOval(
              child: SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.add_circle,
                  size: 30,
                  // color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
