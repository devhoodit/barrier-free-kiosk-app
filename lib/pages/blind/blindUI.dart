import 'package:flutter/material.dart';

class BlindUI extends StatelessWidget {
  final Container container1,
      container2,
      container3,
      container4,
      container5,
      container6;
  const BlindUI(
      {Key? key,
      required this.container1,
      required this.container2,
      required this.container3,
      required this.container4,
      required this.container5,
      required this.container6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: container1),
                Expanded(child: container2),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: container3),
                Expanded(child: container4),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: container5),
                Expanded(child: container6),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Container createButton(
  String text, {
  void Function()? onTap,
  void Function()? onLongPress,
  void Function()? onDoubleTap,
  TextStyle? textStyle,
  BoxDecoration? boxDecoration,
}) {
  Container container = Container(
    child: GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      child: Container(
        decoration: boxDecoration ??
            BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
        constraints: const BoxConstraints.expand(),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? TextStyle(fontSize: 30),
          ),
        ),
      ),
    ),
  );
  return container;
}
