import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BSListViewItem<T> extends StatefulWidget {
  final GlobalKey<_BSListViewItemState<T>> _itemKey = GlobalKey();
  final BuildContext context;
  final Animation animation;
  final BSListViewItemData<T> itemData;
  final Widget Function(BuildContext context, int index, T value) builder;

  BSListViewItem(
      {Key key, this.context, this.animation, this.itemData, this.builder})
      : super(key: key);

  @override
  _BSListViewItemState<T> createState() => _BSListViewItemState<T>();

  Size getSize() {
    return (_itemKey.currentContext.findRenderObject() as RenderBox).size;
  }

  T getCurrentValue() {
    return _itemKey.currentState.currentValue;
  }
}

class _BSListViewItemState<T> extends State<BSListViewItem<T>> {
  T currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.itemData.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.itemData.updateStream,
      builder: (context, snapshot) {
        currentValue = snapshot.data;

        return SizeTransition(
          sizeFactor: widget.animation,
          key: widget._itemKey,
          child: widget.builder(context, widget.itemData.index, currentValue),
        );
      },
      initialData: widget.itemData.initialValue,
    );
  }
}

class BSListViewItemData<T> {
  final int index;
  final T initialValue;
  final BehaviorSubject<T> updateStream;
  BSListViewItem<T> view;
  T currentValue;

  BSListViewItemData({this.index, this.initialValue, this.updateStream}) {
    currentValue = initialValue;
  }
}
