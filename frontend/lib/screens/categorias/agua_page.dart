import 'package:flutter/material.dart';
import '../../widgets/menuInicio.dart';

class AguaPage extends StatelessWidget {
  const AguaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agua")),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          "Página de Agua",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
