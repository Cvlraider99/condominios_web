import 'dart:convert';
import 'package:condominios_web/administrador/pagoEfectivo/dialogoPagoExitoso.dart';
import 'package:condominios_web/dialogosinicio.dart';
import 'package:condominios_web/modeloPago/opcionesPago.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const color = Color(0xff12C9D5);

class GenerarPago extends StatefulWidget{

  final String id,motivo,cantidad,iduser;
  GenerarPago(this.id,this.motivo,this.cantidad,this.iduser);

  @override
  GenerarPagoState createState () => GenerarPagoState();
}

class GenerarPagoState extends State<GenerarPago> {

  //valores necesarios para seleccionar el tipo de pago
  List<OpcionesPago> opcionesPago = OpcionesPago.obtenerListaPago();
  List<DropdownMenuItem<OpcionesPago>> menuDeSeleccion;
  OpcionesPago opcionPagoSeleccionado;

  //variables para ingresar el monto
  TextEditingController controladorMonto = new TextEditingController();
  String montoFinal;

  //Lo que se hara de primera mano
  @override
  void initState() {
    //Se inicializa el valor de lista desplegable
    menuDeSeleccion = buildDropdownMenuItems(opcionesPago);
    opcionPagoSeleccionado = menuDeSeleccion[0].value;
    //se le pone el valor a el TextBox de Monto
    asignarValor();
    super.initState();
  }

  asignarValor(){
    controladorMonto..text = widget.cantidad; //Se le pone el valor inicial al textBox
    montoFinal = widget.cantidad; // Se le pone el valor de la cantidad 
  }

  //Funcion para inicializar la lista desplegable
  List<DropdownMenuItem<OpcionesPago>> buildDropdownMenuItems(List metodoPago) {
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

  onChangeDropdownItem(OpcionesPago metodoSeleccionado) {
    setState(() {
      opcionPagoSeleccionado = metodoSeleccionado;
      metodoDePago = opcionPagoSeleccionado.name;
    });
  }

  String fechaSeleccionada = '0000/00/00'; //variable para almacenar la fecha
  var banderaFecha = 0;
  var defaultMetodo = true;
  var metodoDePago;

  //variables para cambiar el monto a pagar

  actualizarPago() async { //Actualizar el pago
    String departamento, idadmin;

    estadoespera(context);

    final buscarinfouser = await http.post(Uri.parse("https://olam.com.mx/comprobantes/buscarinfo.php"), body: { //aqui se va a buscar nuevamente toda la info del usuario
      "buscar": widget.iduser,
    });

    var datauserid = json.decode(buscarinfouser.body);

    departamento = datauserid[0]['id_departamento'];

    final buscaradmin = await http.post(Uri.parse("https://olam.com.mx/comprobantes/buscaradmin.php"), body: { //Se busca al administrador de esa persona
      "buscar": widget.iduser,
    });

    var datauser = json.decode(buscaradmin.body);
    idadmin = datauser[0]['id_admin'];

    await http.post(Uri.parse("https://olam.com.mx/comprobantes/pagoEfectivo.php"), body: {
      "buscar": widget.id,
      "iduser": departamento,
      "idadmin": idadmin,
      "fecha": fechaSeleccionada,
      "metodo" : metodoDePago,
      "cantidad" : montoFinal,
    }).
    then((value) => exitoPago(context))
        .catchError((onError) => errorPago(context)
    );
  }
  //fin de subida de comprobante

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
                            Text('Motivo pago: ${widget.motivo}',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                            Text (''),
                            Text('Monto a pagar:',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                            //Aqui se va a poner el text box para que ingrese el monto a pagar
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
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
                                  controller: controladorMonto,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon (
                                        Icons.monetization_on_sharp,
                                      ),
                                      hintText: 'Monto a pagar'
                                  ),
                                  onChanged: (value){
                                    setState(() {
                                      montoFinal = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Text('Seleccione la fecha del Pago',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                            Container (
                              width: MediaQuery.of(context).size.width/1.2,
                              height: MediaQuery.of(context).size.height/15,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
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
                            Container (
                              width: MediaQuery.of(context).size.width/1.2,
                              height: MediaQuery.of(context).size.height/15,
                            ),
                            Text("Seleccione el metodo de pago",
                                style: TextStyle(color: Colors.black26 ,fontSize:18,fontWeight: FontWeight.w500)),
                            Container (
                              width: MediaQuery.of(context).size.width/1.2,
                              height: MediaQuery.of(context).size.height/15,
                            ),
                            DropdownButton(
                              value: opcionPagoSeleccionado,
                              items: menuDeSeleccion,
                              onChanged: onChangeDropdownItem,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/1.2,
                              height: MediaQuery.of(context).size.height/8,
                              child: Column(
                                children:<Widget>[
                                  MaterialButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(5.0)
                                      ),
                                      minWidth: MediaQuery.of(context).size.width/4,
                                      height: 40.0,
                                      onPressed: banderaFecha == 1 && montoFinal.length != 0  ? actualizarPago : null,
                                      color: banderaFecha != 1  && montoFinal.length != 0 ? Colors.black26 : color,
                                      child: Text('Enviar',
                                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
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


  //Funcion que me desplegara el TimePicker
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
}

