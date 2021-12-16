import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//dialogo cuando se ha realizado el pago
Future<void> exitoPago(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Éxito."),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(''),
              Text("Se ha realizado el pago."),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
//dialogo cuando se ha ocurrido un error al realizar el pago
Future<void> errorPago(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error."),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(''),
              Text("Ha ocurrido un error al realizar el pago."),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}