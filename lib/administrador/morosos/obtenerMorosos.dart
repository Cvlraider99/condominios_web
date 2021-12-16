/*En este archivo se sacara la lista de las personas que deben mas de 3 meses*/
import 'dart:convert';
import 'package:condominios_web/administrador/morosos/imprimirMorosos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


const color = Color(0xff12C9D5);

class MorososLista extends StatefulWidget{
  final String id;
  MorososLista(this.id);
  @override
  MorososListaState createState () => MorososListaState();
}
class MorososListaState extends State<MorososLista> {

  var mostrar=[];
  int filtro = 0; //este filtro ira de 3 a 11 meses y de una año en adelante

  void filtroCantidad (){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: new Text('3'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 3;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('4'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 4;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('5'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 5;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('6'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 6;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('7'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 7;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('8'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 8;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('9'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 9;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('10'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 10;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('11'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 11;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('12'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 12;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: new Text('+ 1 año'),
                onTap: () {
                  setState(() {
                    mostrar.clear();
                    filtro = 13;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future <List> getData() async{

    var lista;

    final response = await http.post (Uri.parse("https://olam.com.mx/morosos/listarmorosos.php"), body: {
      "buscar": widget.id,
    });
    lista = json.decode(response.body);
    //Se va a sacar una lista dependiendo de la bandera
    for (int i = 0; i <lista.length; i++)
    {
      if (filtro == 0) //Si el filtro es 0 se pasa tal cual
      {
          mostrar.add(lista[i]);
      }
      else if (filtro == 3)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 4)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 5)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 6)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 7)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 8)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 9)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 10)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 11)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else if (filtro == 12)
      {
        if (int.parse(lista[i]['meses']) == filtro)
          mostrar.add(lista[i]);
      }
      else
      {
        if (int.parse(lista[i]['meses']) > 12)
          mostrar.add(lista[i]);
      }
    }
    return mostrar;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
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
                        filtroCantidad();
                      },
                      color: Colors.pinkAccent,
                      child: Text('Filtros',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                      )
                  ),
                ],
              ),
              creacionFilto(),
            ],
          ),
        )
    );
  }

  Widget creacionFilto() {
    return
      Expanded(  //aqui se generara la lista con informacion especifica de un mes del año
          child: new FutureBuilder<List>(
              future: getData(),
              builder: (context, snapshot){
                if (snapshot.hasError) print (snapshot.error);
                return snapshot.hasData
                    ? new ImprimirMorosos (
                  filtro,
                  list: snapshot.data,
                ) :
                new Center (
                  child: new CircularProgressIndicator(),
                );
              }
          )
      );
  }
}