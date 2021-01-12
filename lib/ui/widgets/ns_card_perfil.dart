import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/widgets/ns_image.dart';

import 'ns_card.dart';

class NSCardPerfil extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color colorBorderSide;
  final double elevation;
  final double borderRadius;
  final double borderSize;
  final String image;
  final SIZE imageSize;
  final Alignment imageAlignment;
  final double customImageWidth;
  final double customImageHeight;

  // Offsets de ajuste de posição,
  // percentual em relação ao tamanho da imagem
  final double imageXaxisOffset;
  final double imageYaxisOffset;

  NSCardPerfil(
    {Key key,
    this.child,
    this.color,
    this.colorBorderSide = Colors.transparent,
    this.elevation = 0.0,
    this.borderSize = 0.0,
    this.borderRadius = 12.0,
    this.image,
    this.imageSize,
    this.imageAlignment = Alignment.topCenter,
    this.imageXaxisOffset = 0,
    this.imageYaxisOffset = 0,
    this.customImageHeight = 147,
    this.customImageWidth = 147}
  ) : super(key: key);

  @override
  _NSCardPerfilState createState() => _NSCardPerfilState();
}

class _NSCardPerfilState extends State<NSCardPerfil> {
  Widget getImage(BoxConstraints constraints) {
    if (widget.image == null) {
      return Container();
    }

    NSImage imageObject = NSImage(
      widget.imageSize,
      customSizeHeight: widget.customImageHeight,
      customSizeWidth: widget.customImageWidth,
      isCircle: true,
      assetName: widget.image,
      borderColor: widget.color == null ? NSTheme.secondaryColorLight : widget.color,
      borderWidth: 10.0,
    );

    double _width = constraints.maxWidth;
    double _height = constraints.maxHeight;
    double _imageWidth = imageObject.getImageWidth();
    double _imageHeight = imageObject.getImageHeight();
    double _xOffset = _imageWidth * widget.imageXaxisOffset / 100;
    double _yOffset = _imageHeight * widget.imageYaxisOffset / 100;
    double _x = 0, _y = 0;

    // Cálculo do posicionamento no eixo X
    if (widget.imageAlignment.x == -1.0)
      _x = _x + _xOffset;

    if (widget.imageAlignment.x == 0) 
      _x = (_width / 2) - (_imageWidth / 2) + _xOffset;

    if (widget.imageAlignment.x == 1) 
      _x = _width - _imageWidth + _xOffset;

    // Cálculo do posicionamento no eixo Y
    if (widget.imageAlignment.y == -1.0)
      _y = _height - _height + _yOffset;

    if (widget.imageAlignment.y == 0) 
      _y = (_height / 2) - (_imageHeight / 2) + _yOffset;

    if (widget.imageAlignment.y == 1.0) 
      _y = _height - _imageHeight + _yOffset;


    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: _y,
            left: _x,
            child: Container(
              child: imageObject,
              decoration: BoxDecoration(
                color: widget.colorBorderSide,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: NSCard(
            elevation: widget.elevation,
            child: widget.child,
            color: widget.color,
          ),
        ),
        
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return getImage(constraints);
          }
        )
      ],
    );
  }
}