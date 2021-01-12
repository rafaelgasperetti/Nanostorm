import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanostorm/src/controller/bloc.dart';
import 'package:nanostorm/src/controller/bloc_list.dart';
import 'package:nanostorm/src/controller/bloc_page.dart';
import 'package:nanostorm/src/state/base_state.dart';
import 'package:nanostorm/ui/base_view.dart';
import 'package:nanostorm/ui/widgets/ns_circular_progress.dart';

import 'bs_list_view_item.dart';

class BSListView<T> extends BaseView {
  final int _animationTime = 50;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<BSListViewItemData<T>> _data = List();
  final Widget Function(BuildContext context, int index, T value) builder;
  final String noInfoLabel;
  final double animationStart = 0;
  final double animationEnd = 300;
  final Stream<T> Function() dataLoader;

  BSListView(
      {Key key,
      this.builder,
      this.noInfoLabel = "Sem informações disponíveis.",
      this.dataLoader,
      BSListViewController controller})
      : super(key: key, showHeader: false, aditionalControllers: controller != null ? [ controller ] : null) {
    _scrollController.addListener(_scrollListener);

    for(Bloc controller in controllers) {
      if (controller is BSListViewController<T>) {
        controller.setList(this);
      }
    }
  }

  @override
  _BSListViewState<T> createState() => _BSListViewState<T>();

  @override
  List<Bloc> getControllers() {
    return null;
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("Fim");
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("Início");
    }
  }

  void addItem(T item, {int idx, Animation animation}) {
    idx = idx ?? _data.length;

    _data.insert(idx, BSListViewItemData<T>(index: idx, initialValue: item));
    if(_listKey.currentState != null) {
      _listKey.currentState
          .insertItem(idx, duration: Duration(milliseconds: _animationTime));
    }
  }

  void updateItem(T item, int idx) {
    _data[idx].updateStream.sink.add(item);
  }

  void removeItem(int idx) {
    BSListViewItemData<T> item = _data.removeAt(idx);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return item.view;
    };
    if (_listKey.currentState != null) {
      _listKey.currentState.removeItem(idx, builder,
          duration: Duration(milliseconds: _animationTime));
    }
  }

  void clear() {
    while (_data.length > 0) {
      removeItem(0);
    }
  }

  Size _getSize() {
    return (_listKey.currentContext.findRenderObject() as RenderBox).size;
  }

  double _getItemHeight() {
    return _data.length == 0 ? 1 : _data[0].view.getSize().height;
  }

  int _firstVisibleIndex() {
    double itemHeight = _getItemHeight();
    double scrollOffset = _scrollController.offset;
    return scrollOffset <= itemHeight
        ? 0
        : ((scrollOffset - itemHeight) / itemHeight).ceil();
  }

  int _getVisibileItemCount() {
    return (_getSize().height / _getItemHeight()).round();
  }

  int _lastVisibleIndex() {
    return (_getItemHeight() * _getVisibileItemCount()).round();
  }

  int getItemCount() {
    return _data.length;
  }

  @override
  BlocPage newStateManagerInstance() {
    // TODO: implement newStateManagerInstance
    return null;
  }
}

class _BSListViewState<T> extends BaseViewState<BSListView<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildLoadingView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return NSCircularProgress(
      color: Colors.black,
    );
  }

  @override
  Widget buildNoInfoView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return Text(widget.noInfoLabel);
  }

  @override
  Widget buildView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return AnimatedList(
      key: widget._listKey,
      shrinkWrap: true,
      controller: widget._scrollController,
      initialItemCount: widget._data.length,
      itemBuilder: (context, index, animation) {
        BSListViewItemData itemData = widget._data[index];
        return buildItemFromData(context, itemData, animation);
      },
    );
  }

  BSListViewItem buildItemFromData(BuildContext context,
      BSListViewItemData<T> itemData, Animation animation) {
    BSListViewItem<T> item = BSListViewItem<T>(
      context: context,
      animation: animation,
      itemData: itemData,
      builder: widget.builder,
    );

    itemData.view = item;

    return item;
  }

  @override
  void dispose() {
    super.dispose();
    widget._scrollController.dispose();
  }
}

class BSListViewController<T> extends BlocList<T> {
  BSListView<T> _list;

  BSListViewController() : super();

  void setList(BSListView<T> list) {
    if (this._list == null) {
      this._list = list;
    }
  }

  void addItem(T item, {int idx}) {
    _list.addItem(item, idx: idx);
  }

  void updateItem(T item, int idx) {
    _list.updateItem(item, idx);
  }

  void removeItem(int idx) {
    _list.removeItem(idx);
  }

  void clear() {
    return _list.clear();
  }

  int getItemCount() {
    return _list?.getItemCount() ?? 0;
  }

  void initializeEvent() {
    clear();
  }

  Stream<T> loadData() {
    return _list.dataLoader();
  }

  void onDataLoaded(T item) {
    addItem(item);
  }

  void afterLoad() {

  }

  void onItemError() {

  }
}