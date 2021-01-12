import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NSCircularProgress extends StatefulWidget {
  final double value;
  final Color color;
  final String label;

  NSCircularProgress({Key key, this.value, this.color, this.label}) : super(key: key);

  @override
  _NSCircularProgressState createState() => _NSCircularProgressState();
}

class _NSCircularProgressState extends State<NSCircularProgress> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          new Opacity(
            child: new ModalBarrier(dismissible: false, color: NSTheme.getBGColor()),
            opacity: NSTheme.getModalOpacity(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //verticalDirection: VerticalDirection.down,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(widget.color ?? NSTheme.getBGColorCardText()),
                value: widget.value,
              ),
              Text(
                StringUtils.isNullOrEmpty(widget.label) ? 'Processando...' : widget.label,
              )
            ],
          ),
        ],
      ),
    );
  }
}