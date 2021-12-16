
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ImprimirMorosos extends StatelessWidget {

  final int bandera; //0 se muestra all, 1 de 3 a 11 y 2 mayores a 1 año
  final List list;
  ImprimirMorosos(this.bandera,{this.list});


  @override
  Widget build(BuildContext context) {
    if (list.length == 0)
    {
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text (
                    'Disculpe, por el momento ninguna persona tiene mas de 3 pagos atrasados',
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
            new Expanded(
              child: ListView.builder(
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (context,i){
                    return new Card(
                      child: Column(
                        children:<Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:<Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text('${list[i]['nombre_condom']}',
                                      style: TextStyle(color: Colors.black54 ,fontSize: 13,fontWeight: FontWeight.w500)),
                                ),
                                Text('${list[i]['numero_dep']}',
                                    style: TextStyle(color: Colors.pinkAccent ,fontSize: 18,fontWeight: FontWeight.w500)),
                                Text('${list[i]['nombre_edificio']}',
                                    style: TextStyle(color: Colors.black87 ,fontSize: 18)),
                                Text('Meses pendientes: ${list[i]['meses']}',
                                    style: TextStyle(color: Colors.black87 ,fontSize: 18)),
                              ],
                            ),
                          ),
                        ],
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