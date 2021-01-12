import 'package:flutter/cupertino.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';

class NSForm extends StatelessWidget{
  final List<Widget> children;

  NSForm({
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(NSTheme.getNSTextFieldPadding() + 4), // 4 é a margin do Card por padrão
      child: Column(
        children: this.children,
      ),
    );
  }
}