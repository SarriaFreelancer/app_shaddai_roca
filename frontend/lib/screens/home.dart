import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import '../widgets/menuInicio.dart';
import 'categorias/agua_page.dart';
import 'categorias/alimentos_page.dart';
import 'categorias/aseo_page.dart';
import 'categorias/energia_page.dart';
import 'categorias/gas_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schaddai Roca"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove('token');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                });
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Cerrar sesión'),
              ),
            ],
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Categorías",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildCategoryButton(context, "Aseo", const AseoPage()),
          _buildCategoryButton(context, "Alimentos", const AlimentosPage()),
          _buildCategoryButton(context, "Energía", const EnergiaPage()),
          _buildCategoryButton(context, "Agua", const AguaPage()),
          _buildCategoryButton(context, "Gas", const GasPage()),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(title),
      ),
    );
  }
}
