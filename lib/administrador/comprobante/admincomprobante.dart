import 'dart:convert';
import 'package:condominios_web/administrador/comprobante/impresionLista.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

const color = Color(0xff12C9D5);

class Nuevoscomprobantes extends StatefulWidget {

  final String id;
  Nuevoscomprobantes(this.id);

  @override
  _Nuevoscomprobantes createState() => _Nuevoscomprobantes();
}

class _Nuevoscomprobantes extends State<Nuevoscomprobantes> {

  Future <List> getData() async{
    final response = await http.post (Uri.parse("https://olam.com.mx/comprobantes/revisar.php"), body: {
      "buscar": widget.id,
    });
    return json.decode(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot){
              if (snapshot.hasError) print (snapshot.error);
              return snapshot.hasData
                  ? new Listacomprobante (widget.id,
                list: snapshot.data,
              )
                  :
              new Center
                (
                child: new CircularProgressIndicator(),
              );
            }
        )
    );
  }
}


