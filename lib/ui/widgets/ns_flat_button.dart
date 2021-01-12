import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';

class NSFlatButton extends StatefulWidget {
  final String labelText;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final COLOR textColor;

  const NSFlatButton({
    Key key, 
    this.labelText, 
    this.onPressed,
    this.backgroundColor,
    this.textColor = COLOR.Highlight,
  }) : super(key: key);

  @override
  _NSFlatButtonState createState() => _NSFlatButtonState();
}

class _NSFlatButtonState extends State<NSFlatButton> {
  @override
  Widget build(BuildContext context) {
    TextAppearance textAppearance = TextAppearance();
    return FlatButton(
      onPressed: widget.onPressed,
      color: widget.backgroundColor ?? NSTheme.getBGColor(),
      child: Text(widget.labelText,
        style: textAppearance.large(
          color: widget.textColor,
          fontWeight: FONT_WEIGHT.Normal
        )
      ),
    );
  }
}
