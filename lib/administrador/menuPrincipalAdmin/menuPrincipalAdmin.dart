import 'package:condominios_web/administrador/comprobante/admincomprobante.dart';
import 'package:condominios_web/administrador/informes/ingresarParametros.dart';
import 'package:condominios_web/administrador/morosos/obtenerMorosos.dart';
import 'package:condominios_web/administrador/pagoEfectivo/buscarUsuarios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const color = Color(0xff12C9D5);
const color2 = Color(0xffe6b219);

class PrincipalAdmin extends StatefulWidget
{
  final String nombre;
  final String paterno;
  final String materno;
  final String id;
  final String nombreCondom;

  PrincipalAdmin(this.nombre,this.paterno,this.materno,this.id,this.nombreCondom);
  @override
  MenuAdmin createState() => MenuAdmin();
}


class MenuAdmin extends State<PrincipalAdmin>{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Card(
          child: Center(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(widget.nombre+" "+ widget.paterno,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        subtitle: Text(widget.nombreCondom,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                        leading: Icon(
                          Icons.account_box_outlined, size: 60.0,
                          color: color2,
                        ),
                      ),
                      Text (''),
                      //primera fila de iconos
                      Row( //Empieza primera linea para botones iconos
                        mainAxisAlignment: MainAxisAlignment.center, //Mantiene centrada la fila
                        children: <Widget>[
                          //Boton de informes
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Material(
                                  elevation: 5.0, //Efecto de elevación del botton
                                  borderRadius: BorderRadius.circular(10.0), //Bordeado del botton
                                  clipBehavior: Clip.hardEdge,
                                  color: Colors.white70,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter, //Mantiene centrado el botton
                                    fit: StackFit.passthrough, //
                                    children: [
                                      Ink.image(
                                        image: AssetImage('assets/informes.png'), //Imagen
                                        fit: BoxFit.cover,
                                        width: 90, //Anchura
                                        height: 90, //Altura
                                        child: InkWell(onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => IngresarParametros(widget.id)),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Boton confirmar comprobantes
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Material(
                                  elevation: 5.0, //Efecto de elevación del botton
                                  borderRadius: BorderRadius.circular(10.0), //Bordeado del botton
                                  clipBehavior: Clip.hardEdge,
                                  color: Colors.white70,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter, //Mantiene centrado el botton
                                    fit: StackFit.passthrough, //
                                    children: [
                                      Ink.image(
                                        image: AssetImage('assets/confirmacionadm.png'), //Imagen
                                        fit: BoxFit.cover,
                                        width: 90, //Anchura
                                        height: 90, //Altura
                                        child: InkWell(onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Nuevoscomprobantes(widget.id)),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),//Termina primera fila de iconos
                      //Inicia Segunda fila de iconos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Boton de pago en efectivo
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Material(
                                  elevation: 5.0, //Efecto de elevación del botton
                                  borderRadius: BorderRadius.circular(10.0), //Bordeado del botton
                                  clipBehavior: Clip.hardEdge,
                                  color: Colors.white70,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter, //Mantiene centrado el botton
                                    fit: StackFit.passthrough, //
                                    children: [
                                      Ink.image(
                                        image: AssetImage('assets/NuevoPago.png'), //Imagen
                                        fit: BoxFit.cover,
                                        width: 90, //Anchura
                                        height: 90, //Altura
                                        child: InkWell(onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => BuscarUsuarios(widget.id)),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Boton de personas que deben mas de 3 meses
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Material(
                                  elevation: 5.0, //Efecto de elevación del botton
                                  borderRadius: BorderRadius.circular(10.0), //Bordeado del botton
                                  clipBehavior: Clip.hardEdge,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter, //Mantiene centrado el botton
                                    fit: StackFit.passthrough, //
                                    children: [
                                      Ink.image(
                                        image: AssetImage('assets/morosos.png'), //Imagen
                                        fit: BoxFit.cover,
                                        width: 90, //Anchura
                                        height: 90, //Altura
                                        child: InkWell(onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => MorososLista(widget.id)),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //termina SEGUNDA fila de iconos
                      //termina fila de iconos
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
