import 'package:condominios_web/administrador/menuPrincipalAdmin/menuPrincipalAdmin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> regresarvalores(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  final token2 = prefs.getString("token2");
  final token3 = prefs.getString("token3");
  final token4 = prefs.getString("token4");
  final token5 = prefs.getString("token5");
  final token6 = prefs.getString("token6");
  //final token7 = prefs.getString("token7");
  //final token8 = prefs.getString("token8");
  //final token9 = prefs.getString("token9");
  //final token10 = prefs.getString("token10");
  final token11 = prefs.getString("token11");
  if (token == 'Confirmado')
  {
    if (token11 == "administrador")
    {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          PrincipalAdmin(
              token2,
              token3,
              token4,
              token5,
              token6)),
              (Route<dynamic> route) => false);
    }
  }
  return token;
}