import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


//Estado de la transaccion seleccionada
Future<void> estadoTransaccion(context,mensaje,imagen) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(''),
              new Image.asset(
                imagen,
                width: 50.0,
                height: 50.0,
              ),
              Text(''),
              Text("$mensaje.",textAlign: TextAlign.center),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Ok."),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
