/*En este archivo esta todo lo necesario para la impresion de todos los comprobantes recibidos*/

import 'package:condominios_web/administrador/comprobante/validacioncomprobante.dart';
import 'package:condominios_web/manejoInfo/formatoContabilidad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const color = Color(0xff12C9D5);

class Listacomprobante extends StatelessWidget {
  final String admin;
  final List list;
  Listacomprobante(this.admin,{this.list});

  @override
  Widget build(BuildContext context) {
    if (list.length == 0)
    {
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text (
                    'Por el momento no se han mandado comprobantes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else
    {
      return new ListView.builder(
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (context,i){
            return new Container(
              padding: const EdgeInsets.all(10.0),
              child: new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Verificar(list[i]['id_transaccion'],list[i]['id_operacion'],list[i]['url'],list[i]['motivo'],formatocontabilidad(list[i]['cantidad']),admin)),// se esta enviando el id de la deuda
                  );
                },
                child: new Card(
                  child: new ListTile(
                    title: new Column(
                      children: <Widget>[
                        new Text('${list[i]['motivo']}',
                          style: TextStyle(fontSize: 25.0, color: color),
                        ),
                        new Text("",
                          style: TextStyle(fontSize: 10.0, color: color),
                        ),
                        new Text('Cantidad: \$${formatocontabilidad(list[i]['cantidad'])}',
                          style: TextStyle(fontSize: 25.0, color: color),
                        ),
                      ],
                    ),
                    leading: new Image (
                      width: 100,
                      height: 100,
                      image: new NetworkImage(list[i]['url'],),
                      fit: BoxFit.contain,
                    ),
                    subtitle: new Text(
                      "Departamento: ${list[i]['numero_dep']}, Edificio: ${list[i]['nombre_edificio']}",
                      style: TextStyle(fontSize: 20.0, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            );
          }
      );
    }
  }
}