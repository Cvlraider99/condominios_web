//En este archivo se van a buscar todos los inquilinos que esten asociados al administrador
import 'dart:convert';
import 'package:condominios_web/administrador/pagoEfectivo/imprimirUsuarios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


const color = Color(0xff12C9D5);

class BuscarUsuarios extends StatefulWidget{
  final String id; //Este es el id del administrador
  BuscarUsuarios(this.id);
  @override
  BuscarUsuariosState createState () => BuscarUsuariosState();
}
class BuscarUsuariosState extends State<BuscarUsuarios> {


  Future <List> obtenerInquilinos() async{
    //Se buscan a todos los inquilinos del administrador
    final response = await http.post (Uri.parse("https://olam.com.mx/aplicacion/buscarusuarios.php"), body: {
      "buscar": widget.id,
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FutureBuilder<List>(
            future: obtenerInquilinos(),
            builder: (context, snapshot){
              if (snapshot.hasError) print (snapshot.error);
              return snapshot.hasData ?
              new ImprimirListaUsuarios (
                listaUsuarios: snapshot.data,
              ):
              new Center (
                child: new CircularProgressIndicator(),
              );
            }
        )
    );
  }
}
