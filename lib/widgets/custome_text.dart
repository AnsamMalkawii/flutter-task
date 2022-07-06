import 'package:flutter/material.dart';

class CustomeText extends StatelessWidget {
  final String? label;
  final Color color;
  final double size;
  final Alignment alignment;
  final FontWeight weight;
  const CustomeText(
      {Key? key,
      required this.label,
      required this.color,
      required this.size,
      this.weight = FontWeight.normal,
      this.alignment = Alignment.topLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        label!,
        style: TextStyle(color: color, fontSize: size, fontWeight: weight),
      ),
    );
  }
}
