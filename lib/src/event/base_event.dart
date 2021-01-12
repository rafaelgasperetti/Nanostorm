import 'package:nanostorm/src/event/end_load_event.dart';
import 'package:nanostorm/src/event/initialize_event.dart';
import 'package:nanostorm/src/event/load_event.dart';
import 'package:nanostorm/src/state/base_state.dart';
import 'package:nanostorm/src/state/finalized_state.dart';
import 'package:nanostorm/src/state/first_load_state.dart';
import 'package:nanostorm/src/state/initialized_state.dart';
import 'package:nanostorm/src/state/loading_state.dart';

abstract class BaseEvent {
  BaseState map(BaseState currentState) {

    BaseState newState;

    if(this is InitializeEvent) {
      newState = InitializedState();
    }
    else if(this is LoadEvent && currentState is InitializedState) {
      newState = FirstLoadState();
    }
    else if(this is LoadEvent && currentState is FirstLoadState) {
      newState = LoadingState();
    }
    else if(this is EndLoadEvent) {
      newState = FinalizedState(hasData: currentState.hasData);
    }
    else {
      newState =  InitializedState();
    }

    return newState;
  }
}