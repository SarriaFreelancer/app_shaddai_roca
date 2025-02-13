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

      if (response["success"]) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Obtener datos guardados de términos
        bool acceptedTerms = prefs.getBool('accepted_terms') ?? false;
        String savedTermsVersion = prefs.getString('terms_version') ?? "";

        // Verificar si es la primera vez o si los términos han cambiado
        if (!acceptedTerms || savedTermsVersion != currentTermsVersion) {
          await prefs.setString(
              'terms_version', currentTermsVersion); // Guardar nueva versión
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TermsPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["message"])),
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
              decoration: InputDecoration(
                labelText: "Contraseña",
                filled: true,
                fillColor: Colors.grey[800],
              ),
              obscureText: true,
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
