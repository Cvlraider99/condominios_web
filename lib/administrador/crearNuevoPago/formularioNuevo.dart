import 'dart:convert';
import 'package:condominios_web/administrador/crearNuevoPago/pagoCreado.dart';
import 'package:condominios_web/dialogosinicio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

const color = Color(0xff12C9D5); //color general que llevaron los botones y cajas de texto


class FormularioNuevo extends StatefulWidget{

  final String idUsuario;
  FormularioNuevo(this.idUsuario);
  @override
  FormularioNuevoState createState() => FormularioNuevoState();
}

class FormularioNuevoState extends State<FormularioNuevo>{
  String idDepa;
  String campoMotivo, campoCantidad;
  String fechaSeleccionada = '0000/00/00'; //variable para almacenar la fecha
  var banderaFecha = 0;


  TextEditingController controladorMotivo = new TextEditingController();
  TextEditingController controladorCantidad = new TextEditingController();


  crearPago() async { //En esta parte se van a checar que los valores esten bien y se subiran a la base de datos
    estadoespera(context);
    //primero se busca el id del departamento del usuario
    final buscarDepa = await http.post(Uri.parse("https://olam.com.mx/crearPago/buscarDepartamento.php"), body: { //Se busca el id del Departamento del usuario
      "buscar": widget.idUsuario,
    });
    //Se guarda el numero en la variable
    var datauser = json.decode(buscarDepa.body);
    idDepa = datauser[0]['id_departamento'];

    //Se pone el pago en el sistema
    await http.post(Uri.parse("https://olam.com.mx/crearPago/crearPago.php"), body: {
      "idDepa": idDepa,
      "motivo": campoMotivo,
      "fecha": fechaSeleccionada,
      "cantidad" : campoCantidad,
    }).
    then((value) => pagoCreado(context))
        .catchError((onError) => errorCrearPago(context)
    );

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: ListView(
            children:<Widget>[
              Center(
                child: Column(
                  children:<Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                        child: Text("Ingrese los datos para generar el nuevo pago",
                            style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.w600))
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                        child: Text("Motivo",
                            style: TextStyle(color: Colors.black ,fontSize: 17,fontWeight: FontWeight.w600))
                    ),
                    Padding( //Padding para el TextBox del Motivo
                      padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: Container (
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
                          cursorColor: color,
                          controller: controladorMotivo,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon (
                                Icons.app_registration,
                              ),
                              hintText: 'Motivo'
                          ),
                          onChanged: (value){
                            setState(() {
                              campoMotivo = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                        child: Text("Cantidad",
                            style: TextStyle(color: Colors.black ,fontSize: 17,fontWeight: FontWeight.w600))
                    ),
                    Padding( //Padding para el TextBox de la cantidad
                      padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: Container (
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
                          cursorColor: color,
                          controller: controladorCantidad,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon (
                                Icons.monetization_on_sharp,
                              ),
                              hintText: 'Cantidad'
                          ),
                          onChanged: (value){
                            setState(() {
                              campoCantidad = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                        child: Text("Fecha",
                            style: TextStyle(color: Colors.black ,fontSize: 17,fontWeight: FontWeight.w600))
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
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
                              cursorColor: color,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: fechaSeleccionada,
                                icon: Icon (
                                  Icons.date_range,
                                  color: color,
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
                    MaterialButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)
                        ),
                        minWidth: MediaQuery.of(context).size.width/4,
                        height: 40.0,
                        onPressed: banderaFecha == 0 ||
                            campoCantidad == null ||
                            campoCantidad.isEmpty ||
                            campoMotivo == null ||
                            campoMotivo.isEmpty  ? null : crearPago,
                        color: banderaFecha == 0 ||
                            campoCantidad == null ||
                            campoCantidad.isEmpty ||
                            campoMotivo == null ||
                            campoMotivo.isEmpty ? Colors.black26 : color,
                        child: Text('Enviar',
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Funcion que me desplegara el TimePicker
  Future<void> botonDeSeleccion() async {
    final DateTime seleccionado = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (seleccionado != null && seleccionado.toString() != fechaSeleccionada)
      setState(() {
        banderaFecha = 1;
        fechaSeleccionada = seleccionado.toString();
        fechaSeleccionada = fechaSeleccionada.substring(0,10);
      });
  }
}