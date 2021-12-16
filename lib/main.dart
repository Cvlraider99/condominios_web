import 'dart:convert';
import 'package:condominios_web/administrador/menuPrincipalAdmin/menuPrincipalAdmin.dart';
import 'package:condominios_web/dialogosinicio.dart';
import 'package:condominios_web/manejoInfo/regresarValores.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'manejoInfo/guardarSesion.dart';

const color = Color(0xff12C9D5); //color general que llevaron los botones y cajas de texto

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  _login createState() => _login();
}

// ignore: camel_case_types
class _login extends State<MyApp>{
  String campousuario, campocontra;

  @override
  void initState (){
    super.initState();
    regresarvalores(context); //funcion que me permite saber si ya se ha ingresado previamente
  }

  TextEditingController controladorusuario = new TextEditingController();
  TextEditingController controladorcontra = new TextEditingController();


  void validacion() async { //validacion
    estadoespera(context);
    final respuestaadmin = await http.post(Uri.parse("https://olam.com.mx/aplicacion/login2.php"), body: {
      "usuario": controladorusuario.text,
      "contra": controladorcontra.text,
    });
    var infoadmin = json.decode(respuestaadmin.body);
    if (infoadmin.length == 0) //Si no se encuentra la informacion en la tabla de admin se cierra sesion
      datosIncorrectos(context);
    else{ //else cuando se encuentre al administrador, se guardara su info
      guardarSesion('Confirmado',
          infoadmin[0]['nombre'],
          infoadmin[0]['paterno'],
          infoadmin[0]['materno'],
          infoadmin[0]['id_admin'],
          infoadmin[0]['nombre_condom'],
          'Nada',
          'Nada',
          'Nada',
          'Nada',
          'administrador');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          PrincipalAdmin(infoadmin[0]['nombre'],
              infoadmin[0]['paterno'],
              infoadmin[0]['materno'],
              infoadmin[0]['id_admin'],
              infoadmin[0]['nombre_condom'])),
              (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Card(
          child: Center(
            child: ListView(
              children:<Widget>[
                Center(
                  child: Column(
                    children:<Widget>[
                      new Image.asset(
                        'assets/logoo.png',
                        width: 250.0,
                        height: 250.0,
                      ),
                      Text(''),
                      Text(''),
                      Container (
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
                          controller: controladorusuario,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon (
                                Icons.email,
                              ),
                              hintText: 'Correo electrónico'
                          ),
                          onChanged: (value){
                            setState(() {
                              campousuario = value;
                            });
                          },
                        ),
                      ),
                      Text(''),
                      Container (
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
                          controller: controladorcontra,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon (
                                Icons.vpn_key,
                              ),
                              hintText: 'Contraseña'
                          ),
                          onChanged: (value){
                            setState(() {
                              campocontra = value;
                            });
                          },
                        ),
                      ),
                      Text(''),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        child: const Text('Iniciar sesión',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: campousuario == null || campousuario.isEmpty || campocontra == null || campocontra.isEmpty ? Colors.black26 : color,
                        shape: new RoundedRectangleBorder( //Redondeo de boton de inicio
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: campousuario == null || campousuario.isEmpty || campocontra == null || campocontra.isEmpty ? null: validacion,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      routes: <String,WidgetBuilder>{
        //rutas futuras
      },
    );
  }
}