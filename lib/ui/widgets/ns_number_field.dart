import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/themes/style_default.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';

class NSNumberField extends StatefulWidget {
  final String labelText;
  final bool enabled;
  final bool obscureText;
  final Color backgroundColor;
  final bool roundedBorder;
  final Function onChanged;
  final Function onSubmitted;
  final TextEditingController controller;
  final double height;

  const NSNumberField(
      {Key key,
      this.labelText,
      this.enabled = true,
      this.obscureText = false,
      this.backgroundColor,
      this.roundedBorder = true,
      this.onChanged,
      this.onSubmitted,
      this.controller,
      this.height = 60.0})
      : super(key: key);

  @override
  _NSTextFieldState createState() => _NSTextFieldState();
}

class _NSTextFieldState extends State<NSNumberField> {
  num _n = 0.0;

  void add() {
    setState(() {
      if (widget.controller.text.trim().isNotEmpty)
        _n = num.parse(widget.controller.text.trim().replaceAll(',', '.'));

      _n++;

      widget.controller.text = _n.toString();
    });
  }

  void minus() {
    setState(() {
      if (widget.controller.text.trim().isNotEmpty)
        _n = num.parse(widget.controller.text.trim().replaceAll(',', '.'));

      _n--;

      widget.controller.text = _n.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextAppearance textAppearance = TextAppearance();
    //double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(NSTheme.getBorderRadiusMultiplier(1))),
              color: NSTheme.secondaryColorLight,
              border: Border.all(color: StyleDefault.grey, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    onTap: minus,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.remove,
                        color: NSTheme.highlightColor,
                      ),
                    )),
                Flexible(
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: textAppearance.extraLarge(
                            color: COLOR.PrimaryDark,
                            fontFamily: FONT_FAMILY.Number),
                        enabled: widget.enabled,
                        obscureText: widget.obscureText,
                        onChanged: widget.onChanged,
                        onSubmitted: widget.onSubmitted,
                        controller: widget.controller,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: add,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.add,
                        color: NSTheme.highlightColor,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
