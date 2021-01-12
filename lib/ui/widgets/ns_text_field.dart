import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';
import 'package:nanostorm/ui/widgets/ns_card.dart';

class NSTextField extends StatefulWidget {
  final String labelText;
  final TextStyle style;
  final bool enabled;
  final bool obscureText;
  final Color backgroundColor;
  final bool roundedBorder;
  final double borderRadius;
  final Function onChanged;
  final Function onSubmitted;
  final bool autofocus;
  final TextEditingController controller;
  final double elevation;
  final TextInputType textInputType;
  final int maxLength;
  final List<TextInputFormatter> textInputFormatter;
  final String errorText;

  const NSTextField(
      {Key key,
      this.labelText,
      this.style,
      this.enabled = true,
      this.obscureText = false,
      this.backgroundColor,
      this.roundedBorder = true,
      this.borderRadius,
      this.onChanged,
      this.onSubmitted,
      this.controller,
      this.autofocus = false,
      this.elevation = 0,
      this.textInputType = TextInputType.text,
      this.maxLength,
      this.textInputFormatter,
      this.errorText})
      : super(key: key);

  @override
  _NSTextFieldState createState() => _NSTextFieldState();
}

class _NSTextFieldState extends State<NSTextField> {
  @override
  Widget build(BuildContext context) {
    TextAppearance textAppearance = TextAppearance();
    return Padding(
      padding: EdgeInsets.all(NSTheme.getNSTextFieldPadding()),
      child: Container(
        child: NSCard(
          borderRadius: (widget.borderRadius == null
              ? NSTheme.getBorderRadiusMultiplier(1)
              : widget.borderRadius),
          color: NSTheme.getBGColorCardText(),
          elevation: widget.elevation,
          child: Padding(
            padding: EdgeInsets.only(top:8, bottom:8, left:20, right:8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: widget.backgroundColor == null
                        ? NSTheme.getBGColorCardText()
                        : widget.backgroundColor,
                    labelText: widget.labelText,
                    border: widget.roundedBorder
                        ? OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(
                                widget.borderRadius == null
                                    ? NSTheme.getBorderRadiusMultiplier(1)
                                    : widget.borderRadius)))
                        : InputBorder.none,
                    enabled: widget.enabled,
                    labelStyle: textAppearance.medium(
                        color: COLOR.Highlight, fontWeight: FONT_WEIGHT.Soft),
                    errorText: widget.errorText,
                  ),
                  style: widget.style,
                  enabled: widget.enabled,
                  obscureText: widget.obscureText,
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  controller: widget.controller,
                  keyboardType: widget.textInputType,
                  maxLength: widget.maxLength,
                  inputFormatters: widget.textInputFormatter),
            ),
          ),
        ),
      ),
    );
  }
}
