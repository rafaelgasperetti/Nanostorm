import 'package:flutter/widgets.dart';
import 'package:nanostorm/src/controller/bloc.dart';
import 'package:nanostorm/src/controller/bloc_manager.dart';
import 'package:nanostorm/src/controller/bloc_page.dart';
import 'package:nanostorm/src/state/base_state.dart';
import 'package:nanostorm/src/state/finalized_state.dart';
import 'package:nanostorm/src/state/first_load_state.dart';
import 'package:nanostorm/src/state/initialized_state.dart';
import 'package:nanostorm/src/state/loading_state.dart';
import 'package:nanostorm/src/state/not_initialized_state.dart';

abstract class BaseView<T extends BlocPage> extends StatefulWidget {
  final List<Bloc> controllers = List<Bloc>();
  final bool showHeader;
  final String headerTitle;
  final BlocStateManager blocStateManager = BlocStateManager();

  BaseView({Key key, this.showHeader = true, this.headerTitle = "", List<Bloc> aditionalControllers}) : super(key: key) {
    BlocPage stateController = getStateController();
    List<Bloc> defaultControllers = getControllers();

    if((defaultControllers == null || defaultControllers.isEmpty) && (aditionalControllers == null || aditionalControllers.isEmpty)
        && stateController == null) {
      throw ArgumentError("Uma view deve possuir ao menos um controlador (default ou adicional)");
    }

    if(stateController != null) {
      controllers.add(stateController);
    }
    else if(stateController != null) {
      throw ArgumentError("O controlador definido em 'getStateController' precisa ser um controlador de estados.");
    }

    _addControllers(defaultControllers, aditionalControllers == null);

    if(aditionalControllers != null) {
      _addControllers(aditionalControllers, true);
    }
  }

  void _addControllers(List<Bloc> controllers, bool checkNullOrEmpty) {
    if(controllers != null && controllers.isNotEmpty) {
      int stateControllers = 0;
      for(Bloc controller in controllers) {
        if(controller is BlocPage) {
          stateControllers++;
          if(stateControllers > 1) {
            throw ArgumentError("Não é possível adicionar mais de um controlador de estado em uma tela. Controlador de estado encontrado: " + controller.runtimeType.toString());
          }
        }
        else if(this.controllers.any((controller2) {
          return controller.runtimeType == controller2.runtimeType;
        })) {
          throw ArgumentError("Não é possível repetir o mesmo tipo de controlador mais de uma vez em uma view. Duplicado: " + controller.runtimeType.toString());
        }
      }

      this.controllers.addAll(controllers);
    }
  }

  BlocPage newStateManagerInstance();

  BlocPage getStateController() {
    if(blocStateManager.stateController == null) {
      blocStateManager.stateController = newStateManagerInstance();
    }

    return blocStateManager.stateController;
  }

  List<Bloc> getControllers();

  T of<T extends Bloc>() {
    for(Bloc controller in controllers) {
      if(controller is T) {
        return controller;
      }
    }
    return null;
  }
}

abstract class BaseViewState<View extends BaseView> extends State<View> {
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    if(widget.showHeader) {
      return  _showBody(context);//TODO:Rever
    }
    else {
      return _showBody(context);
    }
  }

  Widget _showBody(BuildContext context) {
    BlocPage stateController = widget.getStateController();
    List<Bloc> postbackManagementDispatchers = checkManagement();

    if(stateController != null) {
      return StreamBuilder<BaseState>(
          stream: stateController.stateStream,
          initialData: NotInitializedState(),
          builder: (context, snapshot) {
            if(snapshot.data is NotInitializedState || snapshot.data is InitializedState || snapshot.data is LoadingState) {
              return buildLoadingView(context, postbackManagementDispatchers, snapshot);
            }
            else if(snapshot.data is FinalizedState && !(snapshot.data as FinalizedState).hasData) {
              return buildNoInfoView(context, postbackManagementDispatchers, snapshot);
            }
            else {
              return buildLoadingView(context, postbackManagementDispatchers, snapshot);
            }
          });
    }
    else {
      return buildView(context, postbackManagementDispatchers, null);
    }
  }

  Widget buildNoInfoView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot);

  Widget buildLoadingView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot);

  Widget buildView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot);

  List<Bloc> checkManagement() {
    List<Bloc> ret = List();
    for(Bloc controller in widget.controllers) {
      dispatchStateManagement(controller);
      ret.add(controller);
    }

    return ret;
  }

  void dispatchStateManagement<T extends Bloc>(T bloc) {
    if(!(bloc.state is FinalizedState)) {
      WidgetsBinding.instance.addPostFrameCallback((duration) => bloc.manageState());
    }
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    for(Bloc controller in widget.controllers) {
      controller.dispose();
    }
  }
}