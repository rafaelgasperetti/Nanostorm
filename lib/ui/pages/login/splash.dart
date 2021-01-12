import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nanostorm/src/controller/Login/splash_controller.dart';
import 'package:nanostorm/src/controller/bloc.dart';
import 'package:nanostorm/src/controller/bloc_page.dart';
import 'package:nanostorm/src/state/base_state.dart';
import 'package:nanostorm/ui/base_view.dart';
import 'package:nanostorm/ui/pages/login/login.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';

class Splash extends BaseView {
  @override
  _SplashState createState() => _SplashState();

  @override
  List<Bloc> getControllers() {
    return null;
  }

  @override
  BlocPage newStateManagerInstance() {
    return SplashController();
  }
}

class _SplashState extends BaseViewState<Splash> {
  @override
  Widget buildLoadingView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return buildView(context, postbackManagementDispatchers, snapshot);
  }

  @override
  Widget buildNoInfoView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return buildView(context, postbackManagementDispatchers, snapshot);
  }

  @override
  Widget buildView(BuildContext context, List<Bloc> postbackManagementDispatchers, AsyncSnapshot<BaseState> snapshot) {
    return Container(
      decoration: BoxDecoration(color: NSTheme.getBGColorMenu()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            NSTheme.getImageSplash(),
          ),
          CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(NSTheme.getBGColorCardText()),
          )
        ],
      ),
    );
  }
}