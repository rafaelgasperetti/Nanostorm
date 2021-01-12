import 'package:nanostorm/src/controller/bloc.dart';
import 'package:nanostorm/src/event/base_event.dart';

abstract class BlocList<T> extends Bloc {
  @override
  void finalizeState() {
    // TODO: implement finalizeState
  }

  @override
  BaseEvent getEvent() {
    // TODO: implement getEvent
    return null;
  }

  @override
  Future manageState() {
    // TODO: implement manageState
    return null;
  }

  @override
  void reset() {
    // TODO: implement reset
  }
}