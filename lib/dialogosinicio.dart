import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Dialogo cuando se esta en estado de espera
Future<void> estadoespera(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Se estan validando sus datos'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
            ],
          ),
        ),
        actions: <Widget>[
          CircularProgressIndicator()
        ],
      );
    },
  );
}
//Dialogo cuando ya se ha enviado el comunicado o el logro
Future<void> datosIncorrectos(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Al parecer sus datos son incorrectos, intente nuevamente.'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(''),
              Text('Verifique que haya escrito sus datos correctamente.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}