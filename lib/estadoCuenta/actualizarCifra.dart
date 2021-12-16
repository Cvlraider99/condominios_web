import 'package:http/http.dart' as http;

void actualizarCifra (String idoperacion, String nuevaCifra) async { //validacion

  await http.post(Uri.parse("https://olam.com.mx/comprobantes/actualizarCifra.php"), body: {
    "idoperacion":idoperacion,
    "cantidad": nuevaCifra,
  });
}