import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/widgets/ns_badge.dart';
import 'package:nanostorm/ui/widgets/ns_image.dart';

class NSAppBar extends StatefulWidget {
  final titulo, exibirBusca, exibirCarrinho;
  final Stream productsInCart;


  NSAppBar(this.titulo, this.exibirBusca, this.exibirCarrinho, this.productsInCart) : super();

  @override
  _NSAppBarState createState() => _NSAppBarState();
}

class _NSAppBarState extends State<NSAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      decoration: BoxDecoration(),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Center(
              child: NSImage(
                SIZE.CUSTOM,
                customSizeWidth: 47,
                customSizeHeight: 23,
                assetName: NSTheme.getImageAppBar(),
              ),
            ),
          ),
          Spacer(),
          Center(child: Text(widget.titulo)),
          Spacer(),
          Visibility(
            visible: widget.exibirBusca,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: GestureDetector(
              child: Container(
                child: Center(
                  child: NSImage(SIZE.TINY, assetName: 'assets/images/ic_lupa.png',)
                ),
              ),
              onTap: () => Navigator.pushNamed(context, "/busca"),
            ),
          ),
          Visibility(
            visible: widget.exibirCarrinho,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: GestureDetector(
                child: Container(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        NSImage(
                          SIZE.TINY,
                          assetName: 'assets/images/ic_cesta.png',
                        ),
                        StreamBuilder<Object>(
                          stream: widget.productsInCart,
                          builder: (context, snapshot) {
                            int valueBadge = 0;
                            if (snapshot.hasData)
                              valueBadge = snapshot.data;
                              
                            return NSBadge(value: valueBadge, top: 1, right: 1);
                          }
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, "/carrinho"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
