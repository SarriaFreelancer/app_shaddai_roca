import 'package:flutter/material.dart';
import '../../widgets/menuInicio.dart';

class EnergiaPage extends StatelessWidget {
  const EnergiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Energía")),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          "Página de Energía",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
