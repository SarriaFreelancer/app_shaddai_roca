import 'package:flutter/material.dart';
import 'login.dart';
import '../services/api_service.dart'; // Ajusta la ruta si es diferente

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Las contraseñas no coinciden";
      });
      return;
    }

    try {
      await ApiService.registerUser(
        cedula: _cedulaController.text,
        nombre: _nombreController.text,
        telefono: _telefonoController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Si el registro es exitoso, navegar al LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cedulaController,
              decoration: InputDecoration(
                  labelText: "Cédula",
                  filled: true,
                  fillColor: Colors.grey[800]),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                  labelText: "Nombre",
                  filled: true,
                  fillColor: Colors.grey[800]),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _telefonoController,
              decoration: InputDecoration(
                  labelText: "Teléfono",
                  filled: true,
                  fillColor: Colors.grey[800]),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: "Correo Electrónico",
                  filled: true,
                  fillColor: Colors.grey[800]),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: "Contraseña",
                  filled: true,
                  fillColor: Colors.grey[800]),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  labelText: "Confirmar Contraseña",
                  filled: true,
                  fillColor: Colors.grey[800]),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}
