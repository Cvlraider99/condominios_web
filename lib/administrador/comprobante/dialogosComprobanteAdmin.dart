import 'dart:io';
import 'package:condominios_web/administrador/menuPrincipalAdmin/menuPrincipalAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Dialogo cuando se esta en estado de espera
Future<void> estadoespera(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      if(Platform.isIOS){
        return CupertinoAlertDialog(
          content: CupertinoActivityIndicator(
            radius: 15,
          ),
        );
      }
      else{
        return AlertDialog(
          title: Text("Espere un momento..."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Se están validando sus datos.")
              ],
            ),
          ),
          actions: <Widget>[
            CircularProgressIndicator()
          ],
        );
      }
    },
  );
}
//Dialogo cuando ya se ha rechazado el comprobante
Future<void> rechazado(String nombre,String paterno,String materno,String idAdmin,String condominio,context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      if (Platform.isIOS)
      {
        return CupertinoAlertDialog(
          title: new Text("Éxito."),
          content: new Text("Se ha rechazado el comprobante.",textAlign: TextAlign.start,),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    PrincipalAdmin(nombre,paterno,materno,idAdmin,condominio)), (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      }
      else{
        return AlertDialog(
          title: Text("Éxito."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(''),
                Text("Se ha rechazado el comprobante."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    PrincipalAdmin(nombre,paterno,materno,idAdmin,condominio)), (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      }
    },
  );
}
//dialogo cuando se ha aceptado el comprobrante
Future<void> aceptado(String nombre,String paterno,String materno,String idAdmin,String condominio,context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      if (Platform.isIOS)
      {
        return CupertinoAlertDialog(
          title: new Text("Éxito."),
          content: new Text("Se ha aprobado el comprobante.",textAlign: TextAlign.start,),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    PrincipalAdmin(nombre,paterno,materno,idAdmin,condominio)), (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      }
      else{
        return AlertDialog(
          title: Text("Éxito."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(''),
                Text("Se ha aprobado el comprobante."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    PrincipalAdmin(nombre,paterno,materno,idAdmin,condominio)), (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      }
    },
  );
}