/*En este archivo esta la presentacion para hacer la validacion del comprobante*/

import 'package:condominios_web/administrador/informes/busquedaParametros.dart';
import 'package:condominios_web/administrador/informes/modeloOpciones.dart';
import 'package:condominios_web/modeloPago/opcionesPago.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

const color = Color(0xff12C9D5); //color general que llevaron los botones y cajas de texto

class IngresarParametros extends StatefulWidget{

  final String idAdmin;
  IngresarParametros(this.idAdmin);

  @override
  IngresarParametrosState createState () => IngresarParametrosState();
}

class IngresarParametrosState extends State<IngresarParametros> {


  //valores necesarios para seleccionar el tipo de pago
  List<OpcionesPago> opcionesPago = OpcionesPago.obtenerListaPago();
  List<DropdownMenuItem<OpcionesPago>> menuDeSeleccion;
  OpcionesPago opcionPagoSeleccionado;
  //valores para el seleccionador de tiempo
  List<OpcionesTiempo> _opcionesTiempo = OpcionesTiempo.getCompanies();
  List<DropdownMenuItem<OpcionesTiempo>> _dropdownMenuItems;
  OpcionesTiempo _tiemposeleccionado;


  @override
  void initState() {
    menuDeSeleccion = buildDropdownMenuItemsPago(opcionesPago);
    opcionPagoSeleccionado = menuDeSeleccion[0].value;
    _dropdownMenuItems = buildDropdownMenuItems(_opcionesTiempo);
    _tiemposeleccionado = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<OpcionesTiempo>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<OpcionesTiempo>> items = [];
    for (OpcionesTiempo company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(OpcionesTiempo selectedCompany) {
    setState(() {
      _tiemposeleccionado = selectedCompany;
      print (_tiemposeleccionado);
    });
  }

  //Funciones para el metodo de pago
  List<DropdownMenuItem<OpcionesPago>> buildDropdownMenuItemsPago(List metodoPago) {
    List<DropdownMenuItem<OpcionesPago>> items = [];
    for (OpcionesPago metodo in metodoPago) {
      items.add(
        DropdownMenuItem(
          value: metodo,
          child: Text(metodo.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItemPago(OpcionesPago metodoSeleccionado) {
    setState(() {
      opcionPagoSeleccionado = metodoSeleccionado;
      metodoDePago = opcionPagoSeleccionado.name;
    });
  }

  var defaultMetodo = true;
  var metodoDePago;
  String fechaSeleccionada = '0000/00/00'; //variable para almacenar la fecha
  String fechaSeleccionadaMes = '0000/00'; //variable para almacenar la fecha
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
                            //Lista desplegable con los tiempos
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
                                        Text("Seleccione el tipo de informe que desea",
                                            style: TextStyle(color: Colors.black26 ,fontSize:18,fontWeight: FontWeight.w500)),
                                        DropdownButton(
                                          value: _tiemposeleccionado,
                                          items: _dropdownMenuItems,
                                          onChanged: onChangeDropdownItem,
                                        ),
                                      ],
                                    )
                                )
                            ),
                            //Antes de los botones estara la lista desplegable de los metodos de pago
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
                                        DropdownButton(
                                          value: opcionPagoSeleccionado,
                                          items: menuDeSeleccion,
                                          onChanged: onChangeDropdownItemPago,
                                        ),
                                      ],
                                    )
                                )
                            ),
                            //Ahora se va a sacar la fecha del deposito
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 10, 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Fecha del informe",
                                    style: TextStyle(color: Colors.black26 ,fontSize:18,fontWeight: FontWeight.w500)),
                              ),
                            ),
                            _tiemposeleccionado.name == "Día" ?
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
                            ):
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
                                      cursorColor: color,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: fechaSeleccionadaMes,
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
                                      tipoDeFuente();
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
                                      onPressed: (){
                                        if (banderaFecha == 1)
                                          busquedaParametros(widget.idAdmin,_tiemposeleccionado.name,fechaSeleccionada,fechaSeleccionadaMes,metodoDePago);
                                      },
                                      color: banderaFecha == 1 ? Colors.lightGreen : Colors.transparent,
                                      child: Text('Generar PDF',
                                        style: TextStyle(fontSize: 20, color: banderaFecha == 1 ? Colors.white : Colors.transparent, fontWeight: FontWeight.w400),
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

  //funcion para sacar la fecha en meses y año
  void tipoDeFuente (){
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
    ).then((date){
      setState(() {
        banderaFecha = 1;
        fechaSeleccionadaMes = date.toString();
        fechaSeleccionadaMes = fechaSeleccionadaMes.substring(0,7);
      });
    });
  }
}