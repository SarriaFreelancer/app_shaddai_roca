import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'home.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool accepted = false;

  // Future<void> acceptTerms() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? email = prefs.getString('email'); // Obtener email guardado
  //   print("📩 Email guardado en SharedPreferences: $email");
  //   if (email != null) {
  //     try {
  //       await ApiService.acceptTerms(email, "1.0"); // Enviar datos al backend
  //       await prefs.setBool('accepted_terms', true);
  //       await prefs.setString('terms_version', "1.0");
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Error al aceptar términos: $e")),
  //       );
  //     }
  //   }
  // }

  Future<void> acceptTerms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      try {
        print("🔹 Enviando solicitud a la API...");
        var response = await ApiService.acceptTerms(email, "1.0");
        print("🔹 Respuesta de la API: $response");

        await prefs.setBool('accepted_terms', true);
        await prefs.setString('terms_version', "1.0");

        print("🔹 Redirigiendo a HomePage...");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        print("❌ Error al aceptar términos: $e");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al aceptar términos: $e")),
        );
      }
    } else {
      print("❌ No se encontró el email en SharedPreferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Términos y Condiciones")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "Debes aceptar nuestros términos y condiciones antes de continuar...",
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: accepted,
                  onChanged: (value) {
                    print("📌 Checkbox cambiado a: $value");
                    setState(() {
                      accepted = value!;
                    });
                  },
                ),
                const Text("Acepto los términos y condiciones"),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: accepted ? acceptTerms : null,
              child: const Text("Aceptar y continuar"),
            ),
          ],
        ),
      ),
    );
  }
}
