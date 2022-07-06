import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../models/alphabets.dart';
import '../../../widgets/custome_text.dart';

class CardTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var alphabet = context.watch<Alphabets>();
    return GestureDetector(
      onTap: () {
        alphabet.toggleIsChoosed();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.blue),
          child: alphabet.isChossed
              ? CustomeText(
                  label: alphabet.example,
                  size: 32,
                  color: Colors.white,
                  alignment: Alignment.center,
                )
              : CustomeText(
                  label: alphabet.arabicAlpha,
                  size: 28,
                  color: Colors.white,
                  alignment: Alignment.center,
                ),
        ),
      ),
    );
  }
}
