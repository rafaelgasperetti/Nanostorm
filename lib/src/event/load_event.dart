import 'package:nanostorm/src/event/base_event.dart';

class LoadEvent<T> extends BaseEvent {
  double progress = 0.0;

  final Stream<T> Function() dataLoader;
  final void Function(T item) onDataLoaded;
  final void Function() onStreamDone;
  final double Function() updateProgress;
  final void Function(T item, Object error) onItemError;

  LoadEvent({this.dataLoader, this.onDataLoaded, this.updateProgress, this.onStreamDone, this.onItemError});

  void loadData() {
    if(dataLoader != null) {
      Stream<T> loader = dataLoader();

      if(loader != null) {
        loader.listen((item) => _onDataLoaded(item)).onDone(() => _onStreamDone());
      }
      else {
        _onStreamDone();
      }
    }
  }

  void _onDataLoaded(T item) {
    if(onDataLoaded != null) {
      try {
        onDataLoaded(item);
      }
      catch(e) {
        _onItemError(item, e);
      }
    }
  }

  void _onStreamDone() {
    if(onStreamDone != null) {
      onStreamDone();
    }
    if(updateProgress != null) {
      updateProgress();
    }
  }

  void _onItemError(T item, Object error) {
    if(onItemError != null) {
      onItemError(item, error);
    }
  }
}