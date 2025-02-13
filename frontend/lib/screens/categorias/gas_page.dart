import 'package:flutter/material.dart';
import '../../widgets/menuInicio.dart';

class GasPage extends StatelessWidget {
  const GasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gas")),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          "Página de Gas",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
