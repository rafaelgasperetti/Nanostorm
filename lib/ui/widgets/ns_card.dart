import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NSCard extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color colorBorderSide;
  final double elevation;
  final double borderRadius;

  NSCard(
      {Key key,
      this.child,
      this.color,
      this.colorBorderSide = Colors.transparent,
      this.elevation = 1.5,
      this.borderRadius = 20,
      })
      : super(key: key);

  @override
  _NSCardState createState() => _NSCardState();
}

class _NSCardState extends State<NSCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          side: BorderSide(color: widget.colorBorderSide)
        ),
        elevation: widget.elevation,
        child: widget.child,
        color: widget.color
      ),
    );
  }
}
