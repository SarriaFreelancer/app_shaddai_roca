import 'package:flutter/material.dart';
import '../../widgets/menuInicio.dart';

class AlimentosPage extends StatelessWidget {
  const AlimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alimentos")),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          "Página de Alimentos",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
