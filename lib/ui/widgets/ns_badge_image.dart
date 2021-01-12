import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';
import 'package:nanostorm/ui/widgets/ns_image.dart';

class NSBadgeImage extends StatefulWidget {
  final num value;
  final Color bgColor;
  final double right;
  final double top;
  final String assetName;
  final double imageSize;
  final EdgeInsetsGeometry padding;

  NSBadgeImage({
    Key key,
    @required this.assetName,
    this.value = 0,
    this.bgColor,
    this.right = 0,
    this.top = 0,
    this.imageSize = 20,
    this.padding,
  }) : super(key: key);

  @override
  _NSBadgeImageState createState() => _NSBadgeImageState();
}

class _NSBadgeImageState extends State<NSBadgeImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: (widget.value != 0)
          ? Stack(
              children: <Widget>[_showImage(), _showBadge()],
            )
          : Container(),
    );
  }

  Widget _showImage() {
    return Padding(
      padding: EdgeInsets.only(right: 6, top: 1),
      child: new Container(
        child: NSImage(
          SIZE.CUSTOM,
          customSizeHeight: widget.imageSize,
          customSizeWidth: widget.imageSize,
          assetName: widget.assetName,
        ),
      ),
    );
  }

  Widget _showBadge() {
    return Positioned(
      right: widget.right,
      top: widget.top,
      child: Stack(
        children: <Widget>[
          Container(
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
              style: TextAppearance()
                  .tiny(fontFamily: FONT_FAMILY.Number, color: COLOR.Secondary),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
