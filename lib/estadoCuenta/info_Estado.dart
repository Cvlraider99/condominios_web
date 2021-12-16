/*En este archivo esta la forma de desplegar la informacion del estado de cuenta*/
import 'package:condominios_web/administrador/pagoEfectivo/generarPago.dart';
import 'package:condominios_web/estadoCuenta/actualizarCifra.dart';
import 'package:condominios_web/estadoCuenta/emergenteComprobante.dart';
import 'package:condominios_web/estadoCuenta/sumarInteres.dart';
import 'package:condominios_web/manejoInfo/formatoContabilidad.dart';
import 'package:condominios_web/recibos/buscarInfoRecibo.dart';
import 'package:condominios_web/recibos/crearRecibo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// ignore: camel_case_types
class infoEstado extends StatefulWidget {

  final int banderaLugar; // bandera para saber desde donde viene y redirigirlo de forma correcta
  //0 si viene desde el menu de usuario
  //1 si viene desde el administrador
  final int banderamodo; //bandera para saber si se puso en un mes especifico
  final String iduser;
  final List list;
  infoEstado(this.banderaLugar,this.banderamodo, this.iduser,{this.list});
  @override
  vista createState () => vista();
}

// ignore: camel_case_types
class vista extends State<infoEstado> {

  var mes = new DateTime.now();
  var formatomes = new DateFormat('MM');
  var dia = new DateTime.now();
  var formatodia = new DateFormat('dd');
  var anio = new DateTime.now();
  var formatoanio = new DateFormat('yyyy');

  String name;
  int aviso,deudas,conversion;

  @override
  Widget build(BuildContext context) {
    if (widget.list.length == 0)
    {
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(''),
                  widget.banderamodo == 0 ?
                  Text ('Por el momento no tenemos movimientos registrados.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600)):
                  Text('No se tienen movimientos registrados en el lapso de tiempo seleccionado',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else
    {
      deudas = 0;
      String mesFinal = formatomes.format(mes);
      String diaFinal = formatodia.format(dia);
      String anioFinal = formatoanio.format(anio);


      for (int i = 0; i<widget.list.length; i++)
      {
        if (widget.list[i]['estado']=='Pendiente' || widget.list[i]['estado']=='Rechazado')
        {
          //se obtiene la fecha primero
          var mesAdeudo = int.parse(widget.list[i]['fecha'].toString().substring(5,7));
          var anioAdeudo = int.parse(widget.list[i]['fecha'].toString().substring(0,4));
          int diaActual = int.parse(diaFinal);
          int mesActual = int.parse(mesFinal);
          int anioActual = int.parse(anioFinal);

          //si ya se le aplico intereses aunque se rechace el comprobante se validara y no se aplicara intereses varias veces
          if (widget.list[i]['intereses'] == '0')
          {
            if (mesAdeudo < mesActual && diaActual > 10)
            {
              //funcion para sumarle 10 a la cantidad
              actualizarCifra(widget.list[i]['id_operacion'], sumarInteres(widget.list[i]['cantidad']));
              setState(() {
                widget.list[i]['cantidad'] = sumarInteres(widget.list[i]['cantidad']);
              });
            }
            else if ((mesAdeudo + 1) < mesActual)
            {
              //funcion para sumarle 10 a la cantidad
              actualizarCifra(widget.list[i]['id_operacion'], sumarInteres(widget.list[i]['cantidad']));
              setState(() {
                widget.list[i]['cantidad'] = sumarInteres(widget.list[i]['cantidad']);
              });
            }
            else if (anioAdeudo < anioActual)
            {
              //funcion para sumarle 10 a la cantidad
              actualizarCifra(widget.list[i]['id_operacion'], sumarInteres(widget.list[i]['cantidad']));
              setState(() {
                widget.list[i]['cantidad'] = sumarInteres(widget.list[i]['cantidad']);
              });
            }
          }
        }
        if (widget.list[i]['estado']=='Pendiente')
        {
          conversion= int.parse(widget.list[i]['cantidad']);
          deudas= deudas + conversion;
        }
        else if(widget.list[i]['estado']=='Rechazado')
        {
          conversion= int.parse(widget.list[i]['cantidad']);
          deudas= deudas + conversion;
        }
        else if(widget.list[i]['estado']=='Intereses')
        {
          conversion= int.parse(widget.list[i]['cantidad']);
          deudas= deudas + conversion;
        }
      }

      return new Scaffold(
        body: new Column(
          children:<Widget>[
            new Column(
              children:<Widget>[
                Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        Text('Total de pagos pendientes: \$$deudas',
                            style: TextStyle(color: Colors.pinkAccent ,fontSize: 20,fontWeight: FontWeight.w600)),
                      ]
                  ),
                )
              ],
            ),
            new Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  itemCount: widget.list == null ? 0 : widget.list.length,
                  itemBuilder: (context,i){
                    if (widget.list[i]['estado']=='Pagado')
                    {
                      name = 'assets/comprobado.png';
                      aviso = 0xff76E910;
                    }
                    else if (widget.list[i]['estado']== 'Revision')
                    {
                      name = 'assets/reloj.png';
                      aviso = 0xffFFF002;
                    }
                    else
                    {
                      name = 'assets/cerrar.png';
                      aviso = 0xffE95C10;
                    }
                    return new Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: new GestureDetector(
                        onTap: () {
                          if (widget.list[i]['estado']=='Pagado')
                          {
                            buscarInformacion(widget.list[i]['id_operacion']);
                          }
                          else if (widget.list[i]['estado']== 'Revision')
                          {
                            estadoTransaccion(context,"Por favor espere a que el administrador revise su comprobante","assets/reloj.png");
                          }
                          else
                          {
                            //aqui va otro if para ver de donde viene y redirigirlo de forma correcta
                            if (widget.banderaLugar == 1)
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GenerarPago(widget.list[i]['id_operacion'],widget.list[i]['motivo'],formatocontabilidad(widget.list[i]['cantidad']), widget.list[i]['id_user'])),// se esta enviando el id de la deuda
                              );
                            }
                          }
                        },
                        child: new Card(
                          child: new Row(
                            children: <Widget>[
                              Padding(padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                                bottom: 5,
                              ),
                                child: new Image.asset(
                                  name,
                                  width: 20.0,
                                  height: 20.0,
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width/100,
                              ),
                              Container (
                                padding: EdgeInsets.only(bottom: 10.0, top: 10),
                                width: MediaQuery.of(context).size.width/1.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:<Widget>[
                                    Text('${widget.list[i]['fecha']} \n${widget.list[i]['motivo']} \nMonto: \$${formatocontabilidad(widget.list[i]['cantidad'])}',
                                        style: TextStyle(color: Colors.black ,fontSize: 18,fontWeight: FontWeight.w400)),
                                    Text('${widget.list[i]['estado']}',
                                        style: TextStyle(color: Color(aviso) ,fontSize: 18,fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ],
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