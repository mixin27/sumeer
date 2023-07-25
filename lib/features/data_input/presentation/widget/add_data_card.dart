import 'package:flutter/material.dart';

class AddDataCard extends StatelessWidget {
  const AddDataCard({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Card(
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Container(
            height: 80,
            padding: const EdgeInsets.only(left: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: onTap,
                    icon: const Icon(
                      Icons.add_circle,
                      size: 40,
                      color: Color(0xFF407BFF),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
