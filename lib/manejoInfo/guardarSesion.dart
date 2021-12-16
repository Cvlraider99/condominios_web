import 'package:shared_preferences/shared_preferences.dart';

guardarSesion (String token, String token2, String token3, String token4, String token5, String token6, String token7, String token8, String token9 , String token10, String token11) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  await prefs.setString('token2', token2);
  await prefs.setString('token3', token3);
  await prefs.setString('token4', token4);
  await prefs.setString('token5', token5);
  await prefs.setString('token6', token6);
  await prefs.setString('token7', token7);
  await prefs.setString('token8', token8);
  await prefs.setString('token9', token9);
  await prefs.setString('token10', token10);
  await prefs.setString('token11', token11);
}