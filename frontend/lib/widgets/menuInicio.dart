import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login.dart';
import '../screens/home.dart';
import '../screens/categorias/aseo_page.dart';
import '../screens/categorias/alimentos_page.dart';
import '../screens/categorias/energia_page.dart';
import '../screens/categorias/agua_page.dart';
import '../screens/categorias/gas_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/king.png', // Reemplaza con la ruta de tu imagen
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Menú de Navegación",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Inicio"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.category),
            title: const Text("Categorías"),
            children: [
              _buildCategoryTile(
                  context, "Aseo", const AseoPage(), Icons.cleaning_services),
              _buildCategoryTile(
                  context, "Alimentos", const AlimentosPage(), Icons.fastfood),
              _buildCategoryTile(
                  context, "Energía", const EnergiaPage(), Icons.flash_on),
              _buildCategoryTile(
                  context, "Agua", const AguaPage(), Icons.water_drop),
              _buildCategoryTile(
                  context, "Gas", const GasPage(), Icons.local_gas_station),
            ],
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Cerrar Sesión"),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(
      BuildContext context, String title, Widget page, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
