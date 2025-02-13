import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool accepted = false;

  Future<void> acceptTerms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('accepted_terms', true);
    await prefs.setString(
        'terms_version', "1.0"); // Guardar versión de términos
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
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
