import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';
import 'ns_card.dart';

class NSDropdownButton extends StatefulWidget {
  final String hint;
  final Object value;
  final Object onChanged;
  final bool isExpanded;
  final List<DropdownMenuItem<Object>> items;
  final double borderRadius;
  final TextStyle style;
  final Alignment textAlign;

  const NSDropdownButton(
      {Key key,
      this.hint,
      this.value,
      this.onChanged,
      this.isExpanded = true,
      this.items,
      this.borderRadius,
      this.style,
      this.textAlign = Alignment.centerRight,
      })
      : super(key: key);

  @override
  _NSDropdownButtonState createState() => _NSDropdownButtonState();
}

class _NSDropdownButtonState extends State<NSDropdownButton> {
  @override
  Widget build(BuildContext context) {
    TextStyle _style;

    if (widget.style == null) {
      _style = TextAppearance().medium(
          color: COLOR.Highlight,
          fontWeight: FONT_WEIGHT.Bold
      );
    } else {
      _style = widget.style;
    }

    return NSCard(
      borderRadius: (widget.borderRadius == null
        ? NSTheme.getBorderRadiusMultiplier(1)
        : widget.borderRadius
      ),
      color: NSTheme.getBGColorCardText(),
      child: Padding(
        padding: EdgeInsets.only(
          top: 6.0, 
          left: 6.0, 
          right: 6.0, 
          bottom: 6.0
        ),

        child: DropdownButton<String>(
          isExpanded: widget.isExpanded,
          hint: Align(
            alignment: widget.textAlign,
            child: Text(
              widget.hint,
              style: _style,
            ), 
          ),
          value: widget.value,
          onChanged: widget.onChanged,
          items: widget.items.toList(),
          underline: Container(),
        ),
      ),
    );
  }
}
