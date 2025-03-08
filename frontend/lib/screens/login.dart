import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'register.dart';
import 'terms.dart';
import 'home.dart';
import '../services/api_service.dart';

// --------------------------------
// PANTALLA DE LOGIN
// --------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _isObscure = true; // Estado para ocultar/mostrar contraseña

  // Versión actual de los términos (actualizar cuando haya cambios)
  static const String currentTermsVersion = "1.0";

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Por favor, ingrese su correo y contraseña.")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await ApiService.login(email, password);
      print("🟢 Respuesta del backend: $response"); // 👈 Verificar respuesta

      if (response["success"] == true) {
        if (response.containsKey("user") && response["user"] != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);

          bool acceptedTerms =
              response["user"]["terms_accepted"].toString() == "1" ||
                  response["user"]["terms_accepted"] == true;

          String savedTermsVersion =
              response["user"]["terms_version"]?.toString() ?? "1.0";

          print("🟢 Términos aceptados: $acceptedTerms");
          print("🟢 Versión guardada: $savedTermsVersion");

          if (acceptedTerms && savedTermsVersion == currentTermsVersion) {
            print("✅ Ir al HomePage");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            print("⚠️ Mostrar TermsPage");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TermsPage()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text("Error: No se encontró información del usuario.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["message"] ?? "Error desconocido.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al iniciar sesión: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Correo electrónico",
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: _isObscure, // Usamos el estado para ocultar/mostrar
              decoration: InputDecoration(
                labelText: "Contraseña",
                filled: true,
                fillColor: Colors.grey[800],
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage()),
                );
              },
              child: const Text("¿Olvidaste tu contraseña?"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : login,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Iniciar sesión"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text("¿No tienes cuenta? Regístrate"),
            ),
          ],
        ),
      ),
    );
  }
}
