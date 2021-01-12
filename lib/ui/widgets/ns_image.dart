import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';

enum SIZE {
  TINY,
  SMALL,
  MEDIUM,
  LARGE,
  EXTRA_LARGE,
  VERY_LARGE,
  CUSTOM,
}

class NSImage extends StatefulWidget {
  final SIZE size;
  double customSizeWidth;
  double customSizeHeight;
  final String url;
  final String assetName;
  final bool isCircle;
  final double borderWidth;
  final Color borderColor;

  NSImage(this.size,
  {
    Key key,
    this.url = '',
    this.assetName = '',
    this.isCircle = false,
    this.customSizeWidth = 90.0,
    this.customSizeHeight = 90.0,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent
  })  
  {
    this.customSizeHeight *= NSTheme.scaleFactor;
    this.customSizeWidth *= NSTheme.scaleFactor;
  }

  double getImageHeight() {
    return (size == SIZE.CUSTOM) 
      ? customSizeHeight * NSTheme.scaleFactor
      : ( size.index * 30.0 + 30.0 ) * NSTheme.scaleFactor;
  }

  double getImageWidth() {
    return (size == SIZE.CUSTOM) 
    ? customSizeWidth * NSTheme.scaleFactor
    : ( size.index * 30.0 + 30.0 ) * NSTheme.scaleFactor;
  }

  @override
  _NSImageState createState() => _NSImageState();
}

class _NSImageState extends State<NSImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.getImageWidth(),
        height: widget.getImageHeight(),
        decoration: buildBoxDecoration());
  }

  Widget buildContainerCustom() {
    return Container(
      width: widget.customSizeWidth,
      height: widget.customSizeHeight,
      decoration: buildBoxDecoration(),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
      image: widget.url.isEmpty
          ? DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(widget.assetName),
            )
          : DecorationImage(fit: BoxFit.fill, image: NetworkImage(widget.url)),
      border: Border.all(
        color: widget.borderColor,
        width: widget.borderWidth,
      ),
    );
  }
}
