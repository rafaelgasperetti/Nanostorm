import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nanostorm/src/controller/Login/login_controller.dart';
import 'package:nanostorm/src/controller/bloc.dart';
import 'package:nanostorm/src/controller/bloc_page.dart';
import 'package:nanostorm/src/state/base_state.dart';
import 'package:nanostorm/ui/base_view.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/themes/text_appearance.dart';
import 'package:nanostorm/ui/widgets/ns_card.dart';

class Login extends BaseView {
  @override
  _LoginState createState() => _LoginState();

  @override
  List<Bloc> getControllers() {

  }

  @override
  BlocPage newStateManagerInstance() {
    return LoginController();
  }
}

class _LoginState extends BaseViewState<Login> {
  @override
  Widget buildLoadingView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return CircularProgressIndicator();
  }

  @override
  Widget buildNoInfoView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return buildView(context, postbackManagementDispatchers, snapshot);
  }

  @override
  Widget buildView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return Scaffold (
      backgroundColor: NSTheme.defaultColor,
      body: Center(
        child: NSCard(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text('Login', textAlign: TextAlign.center,),
              ),
              Spacer(),
              Expanded(
                child: Text('Senha', textAlign: TextAlign.center,),
              )
            ],
          ),
        ),
      )
    );
  }
}