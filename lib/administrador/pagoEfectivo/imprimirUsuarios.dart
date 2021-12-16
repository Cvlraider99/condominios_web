//Se van a imprimir los usuarios que se encontraron
import 'package:condominios_web/estadoCuenta/Estado.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const color = Color(0xff12C9D5); //color general que llevaron los botones y cajas de texto

// ignore: must_be_immutable
class ImprimirListaUsuarios extends StatefulWidget {
  final List listaUsuarios;
  ImprimirListaUsuarios({this.listaUsuarios});
  ImprimirListaUsuariosState createState() => ImprimirListaUsuariosState();
}

class ImprimirListaUsuariosState extends State<ImprimirListaUsuarios>
{
  String campoEdificio;
  var listaCoincidencias = [];
  TextEditingController controladorEdificio = new TextEditingController();


  busqueda(){
    listaCoincidencias.clear();
    for (int i = 0; i<widget.listaUsuarios.length; i++)
    {
      if (widget.listaUsuarios[i]['nombre_edificio'].toString().substring(0,campoEdificio.length) == campoEdificio)
        listaCoincidencias.add(widget.listaUsuarios[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listaUsuarios.length == 0)
    {
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text (
                    'Disculpe, por el momento no tiene ningun usuario registrado',
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
      return new Scaffold(
        body: new Column(
          children:<Widget>[
            Container (
              width: MediaQuery.of(context).size.width/1.2,
              padding: EdgeInsets.only(
                  top: 4, left: 16, right: 16, bottom: 4
              ),
              decoration: BoxDecoration (
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow (
                        color: Colors.black12,
                        blurRadius: 5
                    )
                  ]
              ),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                cursorColor: color,
                controller: controladorEdificio,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon (
                      Icons.search,
                    ),
                    hintText: 'Privada'
                ),
                onChanged: (value){
                  setState(() {
                    campoEdificio = value;
                  });
                  busqueda();
                },
              ),
            ),
            new Expanded(
              child: ListView.builder(
                  itemCount: listaCoincidencias == null ? 0 : listaCoincidencias.length,
                  itemBuilder: (context,i){
                    return new Container(
                      child: new GestureDetector(
                        onTap: () {
                          //se lleva a la impresion del estado de cuenta que se habia hecho anteriormente
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EstadodeCuenta(1, listaCoincidencias[i]['id_user'])),// se esta enviando el id de la deuda
                          );//Cambio de Pantalla
                        },
                        child: new Card(
                          child: ListTile(
                            title: new Text('${listaCoincidencias[i]['nombre_edificio']} ${listaCoincidencias[i]['numero_dep']}',
                              style: TextStyle(fontSize: 20.0, color: Colors.pinkAccent),
                            ),
                            subtitle: new Text('${listaCoincidencias[i]['nombre']} ${listaCoincidencias[i]['paterno']} ${listaCoincidencias[i]['materno']}',
                              style: TextStyle(fontSize: 20.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      );
    }
  }
}