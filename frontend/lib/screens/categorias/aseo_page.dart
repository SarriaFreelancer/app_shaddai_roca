import 'package:flutter/material.dart';
import '../../widgets/menuInicio.dart';

class AseoPage extends StatelessWidget {
  const AseoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aseo")),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          "Página de Aseo",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
