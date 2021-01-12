import 'package:nanostorm/src/event/base_event.dart';

class EndLoadEvent extends BaseEvent {
  final void Function() loadDone;

  EndLoadEvent({this.loadDone});

  void onLoadDone() {
    if(loadDone != null) {
      loadDone();
    }
  }
}