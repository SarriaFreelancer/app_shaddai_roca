import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../widgets/menuInicio.dart';

class AlimentosPage extends StatefulWidget {
  const AlimentosPage({super.key});

  @override
  _AlimentosPageState createState() => _AlimentosPageState();
}

class _AlimentosPageState extends State<AlimentosPage> {
  final List<TextEditingController> productControllers = [];
  final List<TextEditingController> priceControllers = [];
  List<Map<String, dynamic>> historialCompras = [];
  double iva = 0.19;
  double total = 0;
  double valorGeneral = 0;

  @override
  void initState() {
    super.initState();
    _inicializarListas();
    _cargarDatosGuardados();
  }

  void _inicializarListas() {
    for (int i = 0; i < 5; i++) {
      productControllers.add(TextEditingController());
      priceControllers.add(TextEditingController(text: "0"));
    }
  }

  Future<void> _cargarDatosGuardados() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('productos') ?? "[]";
    final List<dynamic> productos = jsonDecode(savedData);

    setState(() {
      if (productos.isNotEmpty) {
        productControllers.clear();
        priceControllers.clear();
        for (var item in productos) {
          productControllers.add(TextEditingController(text: item['nombre']));
          priceControllers
              .add(TextEditingController(text: item['precio'].toString()));
        }
      }
    });
    calcularValores();
  }

  Future<void> _guardarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> productos = [];
    for (int i = 0; i < productControllers.length; i++) {
      productos.add({
        'nombre': productControllers[i].text,
        'precio': priceControllers[i].text
      });
    }
    prefs.setString('productos', jsonEncode(productos));
  }

  void calcularValores() {
    double sum = 0;
    for (var controller in priceControllers) {
      sum += double.tryParse(controller.text) ?? 0;
    }
    setState(() {
      total = sum;
      valorGeneral = total / (1 + iva);
    });
    _guardarDatos();
  }

  void agregarFila() {
    setState(() {
      productControllers.add(TextEditingController());
      priceControllers.add(TextEditingController(text: "0"));
    });
  }

  void eliminarFila(int index) {
    setState(() {
      productControllers[index].dispose();
      priceControllers[index].dispose();
      productControllers.removeAt(index);
      priceControllers.removeAt(index);
    });
    _guardarDatos();
  }

  void limpiarTodo() {
    setState(() {
      productControllers.clear();
      priceControllers.clear();
      _inicializarListas();
    });
    _guardarDatos();
  }

  void guardarCompra() {
    setState(() {
      historialCompras
          .add({"fecha": DateTime.now().toString(), "total": total});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alimentos")),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildResumen(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: productControllers.length,
                itemBuilder: (context, index) {
                  return _buildFilaProducto(index);
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: agregarFila,
                  icon: const Icon(Icons.add),
                  label: const Text("Agregar fila"),
                ),
                ElevatedButton.icon(
                  onPressed: limpiarTodo,
                  icon: const Icon(Icons.delete),
                  label: const Text("Limpiar"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumen() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoCard("IVA", iva.toStringAsFixed(2)),
                  _buildInfoCard("Valor Total", total.toStringAsFixed(2),
                      highlight: true),
                  _buildInfoCard(
                      "Valor General", valorGeneral.toStringAsFixed(2)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: guardarCompra,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Comprar",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilaProducto(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.fastfood, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
              child: TextField(
                  controller: productControllers[index],
                  decoration: InputDecoration(labelText: "Producto"))),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: priceControllers[index],
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) => calcularValores(),
              decoration: const InputDecoration(labelText: "Precio"),
            ),
          ),
          IconButton(
              onPressed: () => eliminarFila(index),
              icon: const Icon(Icons.remove_circle, color: Colors.red)),
        ],
      ),
    );
  }

  // Definición del método _buildInfoCard
  Widget _buildInfoCard(String title, String value, {bool highlight = false}) {
    return Card(
      color: highlight ? Colors.green[100] : Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                  fontSize: 14, color: highlight ? Colors.green : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
