import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';

class NSRaisedButton extends StatefulWidget {
  final String labelText;
  final VoidCallback onPressed;
  final bool expand;
  final double proportion;
  final double elevation;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double height;
  final TextStyle textStyle;

  const NSRaisedButton(
      {Key key,
      this.labelText,
      this.onPressed,
      this.expand = false,
      this.proportion = 1.0,
      this.elevation = 0,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      this.height = 60.0,
      this.textStyle,
      })
      : super(key: key);

  @override
  _NSRaisedButtonState createState() => _NSRaisedButtonState();
}

class _NSRaisedButtonState extends State<NSRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return widget.expand
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: widget.height,
            child: _getRaisedButton())
        : _getRaisedButton();
  }

  Widget _getRaisedButton() {
    TextAppearance textAppearance = TextAppearance();
    return Container(
      width: MediaQuery.of(context).size.width * widget.proportion,
      height: widget.height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                widget.borderRadius == null
                    ? NSTheme.getBorderRadiusMultiplier(1)
                    : widget.borderRadius)),
            side: BorderSide(
                color: widget.borderColor == null
                    ? NSTheme.getAppBarColor()
                    : widget.borderColor)),
        onPressed: widget.onPressed,
        child: Text(widget.labelText,
            style: widget.textStyle ?? textAppearance.large(
                color: COLOR.SecondaryLight, fontWeight: FONT_WEIGHT.Normal)),
        disabledColor: NSTheme.getBGColorMenu(),
        color: (widget.backgroundColor == null
            ? NSTheme.getAppBarColor()
            : widget.backgroundColor),
        elevation: widget.elevation,
      ),
    );
  }
}
