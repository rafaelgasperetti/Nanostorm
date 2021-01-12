import 'package:nanostorm/src/controller/bloc.dart';
import 'package:nanostorm/src/event/base_event.dart';
import 'package:nanostorm/src/event/end_load_event.dart';
import 'package:nanostorm/src/event/initialize_event.dart';
import 'package:nanostorm/src/event/load_event.dart';
import 'package:nanostorm/src/state/base_state.dart';
import 'package:nanostorm/src/state/finalized_state.dart';
import 'package:nanostorm/src/state/loading_state.dart';
import 'package:nanostorm/src/state/not_initialized_state.dart';

abstract class BlocPage<T> extends Bloc {
  int loadedItems = 0;
  bool loadingData = false;

  BlocPage({bool initializeBloc = false}) : super(initializeBloc: initializeBloc);

  @override
  BaseEvent getEvent() {
    if(state is NotInitializedState || (state is FinalizedState && (state as FinalizedState).loadData)) {
      loadingData = false;
      return InitializeEvent(initializer: initializeEvent);
    }
    else if(state is LoadingState && !loadingData) {
      loadingData = true;
      return LoadEvent();
    }
    else {//LoadedState
      loadingData = false;
      return EndLoadEvent(loadDone: finalizeEvent);
    }
  }

  Future manageState() async {
    event = getEvent();

    BaseState newState = event.map(state);

    if(!newState.hasData && loadedItems > 0) {
      newState.hasData = true;
    }

    if(state.runtimeType != newState.runtimeType) {
      state = newState;
    }

    finalizeState();
  }

  @override
  void reset() {

  }

  @override
  void finalizeState() {

  }

  void initializeEvent();

  void loadEvent();

  void finalizeEvent();
}