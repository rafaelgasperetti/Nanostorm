import 'package:nanostorm/src/state/base_state.dart';

class FinalizedState extends BaseState {
  bool loadData;

  FinalizedState({this.loadData = false, bool hasData = false}) {
    super.hasData = hasData;
  }
}