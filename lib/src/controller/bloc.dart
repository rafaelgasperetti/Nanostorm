import 'package:flutter/widgets.dart';
import 'package:nanostorm/src/event/base_event.dart';
import 'package:nanostorm/src/state/base_state.dart';
import 'package:nanostorm/src/state/finalized_state.dart';
import 'package:nanostorm/src/state/not_initialized_state.dart';
import 'package:rxdart/rxdart.dart';

abstract class Bloc {
  final BehaviorSubject<BaseState> stateStream = BehaviorSubject<BaseState>();

  BaseState state = NotInitializedState();
  BaseEvent event;

  Bloc({bool initializeBloc = false}) {
    if(initializeBloc) {
      initialize();
    }
  }

  Future initialize() {
    if(!(state is NotInitializedState)) {
      reset();
    }

    if(state is FinalizedState) {
      (state as FinalizedState).loadData = true;
      notifyView();
    }
    else if(!(state is NotInitializedState)) {
      state = FinalizedState(loadData: true);
      notifyView();
    }
    else {
      return manageState();
    }
  }

  Future manageState();

  BaseEvent getEvent();

  void finalizeState();

  void reset();

  void notifyView() {
    stateStream.sink.add(state);
  }

  @mustCallSuper
  void dispose() {
    stateStream.close();
  }
}