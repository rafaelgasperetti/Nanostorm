import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';

class NSDefaultMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Não há dados a serem exibidos.',
            style: TextAppearance().large(color: COLOR.PrimaryLight),
          ),
        ));
  }
}
