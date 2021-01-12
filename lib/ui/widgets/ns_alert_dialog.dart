import 'package:nanostorm/ui/widgets/ns_flat_button.dart';
import 'package:utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogType { OK, ALERT, ERROR, CONFIRM }

class NSAltertDialog extends StatefulWidget {
  final DialogType type;
  final NSMessage message;
  final String title;
  final String labelPositive;
  final String labelNegative;
  final String labelCancel;
  final Function positiveAction;
  final Function negativeAction;
  final Function cancelAction;

  NSAltertDialog._(
      {Key key,
      this.type,
      this.message,
      this.title,
      this.labelPositive,
      this.labelNegative,
      this.labelCancel,
      this.positiveAction,
      this.negativeAction,
      this.cancelAction})
      : super(key: key);

  @override
  _NSAltertDialogState createState() => _NSAltertDialogState();

  static Future showOKDialog(
      BuildContext context, NSMessage message, String title,
      {String labelPositive = 'Sim', Function positiveAction}) {
    message = messageDefault(message);

    return showDialog(
        context: context,
        builder: (context) {
          return NSAltertDialog._(
              type: DialogType.OK,
              message: message,
              title: title,
              labelPositive: labelPositive,
              positiveAction: positiveAction);
        });
  }

  static Future showAlertDialog(
      BuildContext context, NSMessage message, String title,
      {String labelPositive = 'Sim', Function positiveAction}) {
    message = messageDefault(message);

    return showDialog(
        context: context,
        builder: (context) {
          return NSAltertDialog._(
              type: DialogType.ALERT,
              message: message,
              title: title,
              labelPositive: labelPositive,
              positiveAction: positiveAction);
        });
  }

  static Future showErrorDialog(
      BuildContext context, NSMessage message, String title,
      {String labelNegative = 'Não', Function negativeAction}) {
    message = messageDefault(message);

    return showDialog(
        context: context,
        builder: (context) {
          return NSAltertDialog._(
              type: DialogType.ERROR,
              message: message,
              title: title,
              labelNegative: labelNegative,
              negativeAction: negativeAction);
        });
  }

  static Future showConfirmDialog(
      BuildContext context, NSMessage message, String title,
      {String labelPositive = 'Sim',
      Function positiveAction,
      String labelNegative = 'Não',
      Function negativeAction,
      String labelCancel = 'Cancelar',
      Function cancelAction}) {
    message = messageDefault(message);

    return showDialog(
        context: context,
        builder: (context) {
          return NSAltertDialog._(
              type: DialogType.CONFIRM,
              message: message,
              title: title,
              labelPositive: labelPositive,
              positiveAction: positiveAction,
              labelNegative: labelNegative,
              negativeAction: negativeAction,
              labelCancel: labelCancel,
              cancelAction: cancelAction);
        });
  }

  static NSMessage messageDefault(NSMessage message) {
    if (message == null) {
      message = NSMessage.obterAviso(
          codigo: Codigos.AlertDialog_showNSDialog_NullMessage,
          mensagemAmigavel: NSConstants.NS_ALTERT_DIALOG_NULL_NSMESSAGE);
    }
    return message;
  }
}

class _NSAltertDialogState extends State<NSAltertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.title),
        content: Text(widget.message.toString()),
        actions: _showActions(context));
  }

  List<Widget> _showActions(BuildContext context) {
    List<Widget> widgets = List();

    switch (widget.type) {
      case DialogType.OK:
        widgets.add(NSFlatButton(
            labelText: widget.labelPositive,
            onPressed: () {
              executeAction(context);
            }));
        break;
      case DialogType.ALERT:
        widgets.add(NSFlatButton(
          labelText: widget.labelPositive,
          onPressed: () {
            executeAction(context);
          },
        ));
        break;
      case DialogType.ERROR:
        widgets.add(NSFlatButton(
          labelText: widget.labelNegative,
          onPressed: () {
            executeAction(context);
          },
        ));
        break;
      case DialogType.CONFIRM:
        widgets.add(NSFlatButton(
          labelText: widget.labelPositive,
          onPressed: () {
            executeAction(context);
          },
        ));
        widgets.add(NSFlatButton(
          labelText: widget.labelNegative,
          onPressed: () {
            executeAction(context);
          },
        ));
        widgets.add(NSFlatButton(
          labelText: widget.labelCancel,
          onPressed: () {
            executeAction(context);
          },
        ));
        break;
    }
    return widgets;
  }

  void executeAction(BuildContext context) {
    if(widget.positiveAction != null) {
      Future(() => Navigator.of(context).pop())
          .then((_) => widget.positiveAction(context));
    }
    else {
      Future(() => Navigator.of(context).pop());
    }
  }
}
