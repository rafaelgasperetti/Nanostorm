import 'package:flutter/widgets.dart';
import 'package:nanostorm/src/event/base_event.dart';

class InitializeEvent extends BaseEvent {

  final void Function() initializer;

  InitializeEvent({@required this.initializer}) : assert(initializer != null);

  void initializeEvent() {
    if(initializer != null) {
      initializer();
    }
  }
}