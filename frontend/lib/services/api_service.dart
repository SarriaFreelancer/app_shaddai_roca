import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://localhost:5000/api/auth";

  // Registro de usuario
  static Future<Map<String, dynamic>> registerUser({
    required String cedula,
    required String nombre,
    required String telefono,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "cedula": cedula,
        "nombre": nombre,
        "telefono": telefono,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error en el registro: ${response.body}");
    }
  }

  // Inicio de sesión
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final responseData = jsonDecode(response.body);
    print("🔍 Respuesta del servidor: $responseData"); // 👈 Para depurar

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', responseData['token']);
      await prefs.setString(
          'email', responseData['user']['email']); // Guardar email
      await prefs.setBool(
          'termn_accepted', responseData['user']['termn_accepted'] == 1);
      await prefs.setString(
          'terms_version', responseData['user']['terms_version'] ?? "1.0");

      return {
        "success": true,
        "message": "Inicio de sesión exitoso",
        "user": responseData["user"]
      };
    } else {
      return {"success": false, "message": responseData['error']};
    }
  }

  // Aceptación de terminos y condiciones
  static Future<Map<String, dynamic>> acceptTerms(
      String email, String termsVersion) async {
    final response = await http.post(
      Uri.parse("$baseUrl/accept-terms"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "terms_version": termsVersion,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al aceptar términos: ${response.body}");
    }
  }
}
