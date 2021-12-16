import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'info_Estado.dart';

const color = Color(0xff12C9D5);

class EstadodeCuenta extends StatefulWidget{
  final int banderaLugar; //Esta bandera es para saber desde donde se esta ocupando la funcion
  //0 es desde el modo usuario
  //1 desde el modo administrador
  final String id;
  EstadodeCuenta(this.banderaLugar,this.id);
  @override
  _estado createState () => _estado();
}

// ignore: camel_case_types
class _estado extends State<EstadodeCuenta> {

  DateTime _dataTime; //variable para ver las fechas seleccionadas

  Future <List> infoGeneral() async{
    final response = await http.post (Uri.parse("https://olam.com.mx/aplicacion/estadocuenta.php"), body: {
      "buscar": widget.id,
    });
    return json.decode(response.body);
  }

  Future <List> infoEspecifica() async{
    String mes, anio;
    var sacarmes = new DateFormat('MM');
    var sacaranio = new DateFormat('yyyy');
    mes = sacarmes.format(_dataTime);
    anio = sacaranio.format(_dataTime);
    final response = await http.post (Uri.parse("https://olam.com.mx/aplicacion/estadocuentames.php"), body: {
      "buscar": widget.id,
      "mes": mes,
      "anio": anio
    });
    return json.decode(response.body);
  }

  Widget creacionListado(bandera) {
    return
      Expanded(  //aqui se generara la lista con informacion especifica de un mes del año
          child: FutureBuilder<List>(
              future: bandera == 0 ? infoGeneral() : infoEspecifica(),
              builder: (context, snapshot){
                if (snapshot.hasError) print (snapshot.error);
                return snapshot.hasData
                    ? new infoEstado (
                    widget.banderaLugar,
                    bandera,
                    widget.id,
                    list: snapshot.data
                )
                    :
                new Center (
                  child: new CircularProgressIndicator(),
                );
              }
          )
      );
  }

  void tipoDeFuente (){
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
    ).then((date){
      setState(() {
        _dataTime = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: refreshIndicator,
          child: Card(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                        minWidth: MediaQuery.of(context).size.width/4,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(7.0)
                        ),
                        height: 40.0,
                        onPressed: () {
                          tipoDeFuente();
                        },
                        color: Colors.pinkAccent,
                        child: Text('Mes',
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                        )
                    ),
                  ],
                ),
                _dataTime == null ? creacionListado(0): creacionListado(1)
              ],
            ),
          ),
        ),
      ),
    );
  }
  //funcion para refrescar pantalla
  Future<Null> refreshIndicator (){
    Navigator.pushReplacement(
        context, PageRouteBuilder(pageBuilder: (a,b,c) => EstadodeCuenta(widget.banderaLugar,widget.id),
        transitionDuration: Duration(seconds: 0)));
    return null;
  }
}

