/*En este archivo esta la presentacion para hacer la validacion del comprobante*/

import 'dart:convert';
import 'package:condominios_web/administrador/comprobante/dialogosComprobanteAdmin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

class Verificar extends StatefulWidget{

  final String idtransaccion,idoperacion,url,motivo,cantidad,admin;
  Verificar(this.idtransaccion,this.idoperacion,this.url,this.motivo,this.cantidad,this.admin);

  @override
  VerificarState createState () => VerificarState();
}

class VerificarState extends State<Verificar> {

  var defaultMetodo = true;
  var metodoDePago;
  String fechaSeleccionada = '0000/00/00'; //variable para almacenar la fecha
  var banderaFecha = 0;

  //Funcion para sacar la fecha
  Future<void> botonDeSeleccion() async {
    final DateTime seleccionado = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (seleccionado != null && seleccionado.toString() != fechaSeleccionada)
      setState(() {
        banderaFecha = 1;
        fechaSeleccionada = seleccionado.toString();
        fechaSeleccionada = fechaSeleccionada.substring(0,10);
        //fechaSeleccionada = fechaSeleccionada.replaceAll("-", "/");
      });
  }


  void actualizarc() async { //Funcion de validacion cuando se apruebe el comprobante

    String nombre,paterno,materno,idAdmin,condominio;

    estadoespera(context);

    await http.post(Uri.parse("https://olam.com.mx/comprobantes/aceptar.php"), body: { //aqui se va a buscar nuevamente toda la info del usuario
      "idtran": widget.idtransaccion,
      "idop": widget.idoperacion,
      "metodo" : metodoDePago,
      "fecha" : fechaSeleccionada,
    });

    final buscaradmin = await http.post(Uri.parse("https://olam.com.mx/comprobantes/buscarinfoadmin.php"), body: { //aqui se va a buscar nuevamente toda la info del usuario
      "buscar": widget.admin,
    });

    var datauserid = json.decode(buscaradmin.body);

    nombre=datauserid[0]['nombre'];
    paterno=datauserid[0]['paterno'];
    materno=datauserid[0]['materno'];
    idAdmin=datauserid[0]['id_admin'];
    condominio=datauserid[0]['nombre_condom'];

    aceptado(nombre,paterno,materno,idAdmin,condominio,context);

  }

  void actualizarr() async { //validacion cuando se rechace el comprobante

    String nombre,paterno,materno,idAdmin,condominio;
    estadoespera(context);

    await http.post(Uri.parse("https://olam.com.mx/comprobantes/rechazar.php"), body: { //aqui se va a buscar nuevamente toda la info del usuario
      "idtran": widget.idtransaccion,
      "idop": widget.idoperacion,
    });

    final buscaradmin = await http.post(Uri.parse("https://olam.com.mx/comprobantes/buscarinfoadmin.php"), body: { //aqui se va a buscar nuevamente toda la info del usuario
      "buscar": widget.admin,
    });

    var datauserid = json.decode(buscaradmin.body);

    nombre=datauserid[0]['nombre'];
    paterno=datauserid[0]['paterno'];
    materno=datauserid[0]['materno'];
    idAdmin=datauserid[0]['id_admin'];
    condominio=datauserid[0]['nombre_condom'];

    rechazado(nombre,paterno,materno,idAdmin,condominio,context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
        debugShowCheckedModeBanner: false,

        home: Scaffold(
            body: Center(
                child: Container(
                  child: ListView(
                    children: <Widget> [
                      Center(
                        child: Column(
                          children:<Widget>[
                            Container (
                              width: MediaQuery.of(context).size.width/1.2,
                              height: MediaQuery.of(context).size.height/5,
                              child: Column(
                                children: <Widget>[
                                  Text("",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                                  Text('Motivo: ${widget.motivo}',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                                  Text("",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                                  Text('Monto: \$${widget.cantidad}',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            Container( //En este container se tiene la visualizacion de la imagen (Comprobante)
                              width: MediaQuery.of(context).size.width/1.2,
                              height: MediaQuery.of(context).size.height/1.6,
                              child: PhotoView(
                                imageProvider:
                                new NetworkImage(widget.url),
                              )
                            ),
                            //Antes de los botones estara la lista desplegable
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 10, 20),
                                child: Container ( // Contenedor de la lista desplegable
                                    width: MediaQuery.of(context).size.width/1.2,
                                    padding: EdgeInsets.only(
                                        top: 3, left: 10, right: 10, bottom: 3
                                    ),
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Seleccione el metodo de pago",
                                            style: TextStyle(color: Colors.black26 ,fontSize:18,fontWeight: FontWeight.w500)),
                                        /*StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance.collection("formasDePago")
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot> snapshot) {
                                            if (!snapshot.hasData) return Container();
                                            if (defaultMetodo) {
                                              metodoDePago = snapshot.data.docs[0].get('tipo'); //Pone la primer empresa de la lista como predeterminado
                                            }
                                            return DropdownButton(
                                              focusColor: Colors.white,
                                              isExpanded: false,
                                              value: metodoDePago,
                                              items: snapshot.data.docs.map((value) {
                                                return DropdownMenuItem(
                                                  value: value.get('tipo'),
                                                  child: Text('${value.get('tipo')}'),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                        metodoDePago = value;
                                                        defaultMetodo = false;
                                                        },
                                                );
                                                },
                                            );
                                            },
                                        ),*/
                                      ],
                                    )
                                )
                            ),
                            //Ahora se va a sacar la fecha del deposito
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 10, 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Fecha del movimiento",
                                    style: TextStyle(color: Colors.black26 ,fontSize:18,fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 10, 20),
                              child: Row(
                                children:<Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width /1.7,
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    padding: const EdgeInsets.only (top: 10, bottom: 10,left: 10, right: 5),
                                    decoration: BoxDecoration (
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow (
                                              color: Colors.black12,
                                              blurRadius: 5
                                          )
                                        ]
                                    ),
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: fechaSeleccionada,
                                        icon: Icon (
                                          Icons.date_range,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    color: Colors.pink,
                                    onPressed: () {
                                      botonDeSeleccion();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:<Widget>[
                                  MaterialButton( //boton para aceptar el comprobante
                                      minWidth: MediaQuery.of(context).size.width/4,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(7.0)
                                      ),
                                      height: 40.0,
                                      onPressed: banderaFecha == 1 ? actualizarc: null,
                                      color: banderaFecha == 1 ? Colors.lightGreen : Colors.transparent,
                                      child: Text('Aceptar',
                                        style: TextStyle(fontSize: 20, color: banderaFecha == 1 ? Colors.white : Colors.transparent, fontWeight: FontWeight.w400),
                                      )
                                  ),
                                  Text(' '),
                                  MaterialButton( //boton para rechazar el comprobante
                                      minWidth: MediaQuery.of(context).size.width/4,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(7.0)
                                      ),
                                      height: 40.0,
                                      onPressed: () {
                                        actualizarr();
                                      },
                                      color: Colors.red,
                                      child: Text('Rechazar',
                                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}