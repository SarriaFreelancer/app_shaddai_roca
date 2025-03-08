import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/menuInicio.dart';
import 'package:flutter/services.dart';

class AseoPage extends StatefulWidget {
  const AseoPage({super.key});

  @override
  _AseoPageState createState() => _AseoPageState();
}

class _AseoPageState extends State<AseoPage> {
  final List<TextEditingController> productControllers = [];
  final List<TextEditingController> priceControllers = [];
  double iva = 0.19;
  double total = 0;
  double valorGeneral = 0;

  @override
  void initState() {
    super.initState();
    _inicializarListas();
  }

  void _inicializarListas() {
    for (int i = 0; i < 5; i++) {
      productControllers.add(TextEditingController());
      priceControllers.add(TextEditingController(text: "0"));
    }
  }

  void calcularValores() {
    double sum = 0;
    for (var controller in priceControllers) {
      sum += double.tryParse(controller.text) ?? 0;
    }
    setState(() {
      total = sum;
      valorGeneral = total / (1 + iva); // Cambio en el cálculo del subtotal
    });
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
  }

  void limpiarCampos() {
    setState(() {
      for (var controller in productControllers) {
        controller.clear();
      }
      for (var controller in priceControllers) {
        controller.clear();
      }
      total = 0;
      valorGeneral = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aseo")),
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
            ElevatedButton.icon(
              onPressed: agregarFila,
              icon: const Icon(Icons.add),
              label: const Text("Agregar fila"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: limpiarCampos,
                  child: const Text("Limpiar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción para comprar
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Compra realizada")));
                  },
                  child: const Text("Comprar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumen() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey, width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoCard("IVA", iva.toStringAsFixed(2)),
              _buildInfoCard("Valor Total", total.toStringAsFixed(2)),
              _buildInfoCard("Valor General", valorGeneral.toStringAsFixed(2)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green,
                child: Text(
                  valorGeneral.toStringAsFixed(2),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 100,
                height: 50,
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: valorGeneral > 0 ? valorGeneral : 0,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilaProducto(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.cleaning_services),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: productControllers[index],
                decoration: InputDecoration(
                  labelText: "Producto",
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text("=",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: priceControllers[index],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
                decoration: InputDecoration(
                  labelText: "Precio",
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
                onChanged: (value) => calcularValores(),
              ),
            ),
          ),
          IconButton(
            onPressed: () => eliminarFila(index),
            icon: const Icon(Icons.remove_circle, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "= $value",
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
