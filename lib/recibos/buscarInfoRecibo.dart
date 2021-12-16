import 'dart:convert';


import 'package:condominios_web/recibos/crearRecibo.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

buscarInformacion (String idOperacion)async{

  var lista;

  DateTime now = DateTime.now();
  String formattedDate;
  formattedDate = DateFormat('yyyy-MM-dd').format(now);

  final response = await http.post (Uri.parse("https://olam.com.mx/recibos/buscarInfo.php"), body: {
    "buscar": idOperacion,
  });
  lista = json.decode(response.body);

  crearRecibo(
      lista[0]['id_operacion'],
      lista[0]['cantidad'],
      lista[0]['metodoPago'],
      lista[0]['fechaPago'],
      lista[0]['motivo'],
      lista[0]['nombre_edificio'],
      lista[0]['numero_dep'],
      lista[0]['nombre_condom'],
      formattedDate);

}