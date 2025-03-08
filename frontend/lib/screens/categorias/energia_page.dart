import 'package:flutter/material.dart';
import '../../widgets/menuInicio.dart';

class EnergiaPage extends StatefulWidget {
  const EnergiaPage({super.key});

  @override
  _EnergiaPageState createState() => _EnergiaPageState();
}

class _EnergiaPageState extends State<EnergiaPage> {
  // Controladores de los inputs
  final TextEditingController _lecturaAnteriorController =
      TextEditingController();
  final TextEditingController _lecturaActualController =
      TextEditingController();
  final TextEditingController _diferenciaController = TextEditingController();

  final TextEditingController _codigoFacturaController =
      TextEditingController();
  final TextEditingController _lecturaColaboradorController =
      TextEditingController();
  final TextEditingController _valorM3Controller = TextEditingController();
  final TextEditingController _valorTotalM3Controller = TextEditingController();
  final TextEditingController _diferenciaLecturasController =
      TextEditingController();

  @override
  void dispose() {
    // Liberar los controladores
    _lecturaAnteriorController.dispose();
    _lecturaActualController.dispose();
    _diferenciaController.dispose();
    _codigoFacturaController.dispose();
    _lecturaColaboradorController.dispose();
    _valorM3Controller.dispose();
    _valorTotalM3Controller.dispose();
    _diferenciaLecturasController.dispose();
    super.dispose();
  }

  // Método para limpiar los inputs
  void _limpiarCuadroComparativo() {
    setState(() {
      _lecturaAnteriorController.clear();
      _lecturaActualController.clear();
      _diferenciaController.clear();
      _codigoFacturaController.clear();
      _lecturaColaboradorController.clear();
      _valorM3Controller.clear();
      _valorTotalM3Controller.clear();
      _diferenciaLecturasController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Energía")),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cuadro comparativo de lecturas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Lectura Anterior"),
                            TextField(
                              controller: _lecturaAnteriorController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Lectura Anterior",
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Lectura Actual"),
                            TextField(
                              controller: _lecturaActualController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Lectura Actual",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Icon(Icons.arrow_forward, size: 48),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _diferenciaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Diferencia",
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _limpiarCuadroComparativo,
                      child: const Text("Limpiar Campos"),
                    ),
                  ],
                ),
              ),
            ),

            // Código de factura
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Código"),
                  TextField(
                    controller: _codigoFacturaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Número de Factura",
                    ),
                  ),
                ],
              ),
            ),

            // Módulo de valores relacionados con la factura
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  children: [
                    const Text("Lectura colaborador Celzia"),
                    TextField(
                      controller: _lecturaColaboradorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Lectura colaborador",
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Valor M3"),
                    TextField(
                      controller: _valorM3Controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Valor M3",
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Valor Total M3"),
                    TextField(
                      controller: _valorTotalM3Controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Valor Total M3",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Icon(Icons.arrow_forward, size: 48),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _diferenciaLecturasController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Diferencia",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.circle, color: Colors.red),
                        const SizedBox(width: 8),
                        const Text("Diferencia de lecturas"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Módulo de los 12 meses con valor pagado y estado de pago
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(12, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text("Mes ${index + 1}"),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Valor Pagado",
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.check_circle),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Módulo de pago
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange),
                ),
                child: Column(
                  children: [
                    const Text("Realiza tu pago"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para redirigir a PSI
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Redirigiendo..."),
                              content: const Text(
                                  "Se está redirigiendo al sistema de pago PSI."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cerrar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Ir a PSI para pagar"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
