import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';

class NSBadge extends StatefulWidget {
  final num value;
  final Color bgColor;
  final double right;
  final double top;
  
    NSBadge(
      {Key key,
      this.value = 0,
      this.bgColor,
      this.right = 0,
      this.top = 0 
      })
      : super(key: key);

  @override
  _NSBadgeState createState() => _NSBadgeState();
}

class _NSBadgeState extends State<NSBadge> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
          right: widget.right,
          top: widget.top,
          child: Stack(
              children: <Widget>[
                
                widget.value != 0 ? new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: widget.bgColor ?? NSTheme.getBGColorBadge(),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${widget.value}',
                    style: TextAppearance().tiny(
                      fontFamily: FONT_FAMILY.Number
                      ,color: COLOR.Secondary
                    ),
                    textAlign: TextAlign.center,
                  ),
                ) : new Container()
              ],
            ),
    );
  }
}