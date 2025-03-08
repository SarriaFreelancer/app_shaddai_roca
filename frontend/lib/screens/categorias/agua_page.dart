import 'package:flutter/material.dart';
import '../../widgets/menuInicio.dart';

class AguaPage extends StatefulWidget {
  const AguaPage({super.key});

  @override
  _AguaPageState createState() => _AguaPageState();
}

class _AguaPageState extends State<AguaPage> {
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
      appBar: AppBar(title: const Text("Agua")),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cuadro comparativo de lecturas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCuadroComparativo(),
            ),

            // Código de factura
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCodigoFactura(),
            ),

            // Módulo de valores relacionados con la factura
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildModuloValores(),
            ),

            // Módulo de los 12 meses con valor pagado y estado de pago
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildMesesPagados(),
            ),

            // Módulo de pago
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildModuloPago(),
            ),
          ],
        ),
      ),
    );
  }

  // Cuadro comparativo de lecturas
  Widget _buildCuadroComparativo() {
    return Container(
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
              _buildInputColumn("Lectura Anterior", _lecturaAnteriorController),
              _buildInputColumn("Lectura Actual", _lecturaActualController),
            ],
          ),
          const SizedBox(height: 16),
          Center(child: Icon(Icons.arrow_forward, size: 48)),
          const SizedBox(height: 16),
          _buildTextField("Diferencia", _diferenciaController),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _limpiarCuadroComparativo,
            child: const Text("Limpiar Campos"),
          ),
        ],
      ),
    );
  }

  // Input de texto común
  Widget _buildInputColumn(String label, TextEditingController controller) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: label,
            ),
          ),
        ],
      ),
    );
  }

  // Método para crear un campo de texto
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }

  // Código de factura
  Widget _buildCodigoFactura() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Código"),
        _buildTextField("Número de Factura", _codigoFacturaController),
      ],
    );
  }

  // Módulo de valores relacionados con la factura
  Widget _buildModuloValores() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        children: [
          const Text("Lectura colaborador Celzia"),
          _buildTextField("Lectura colaborador", _lecturaColaboradorController),
          const SizedBox(height: 16),
          const Text("Valor M3"),
          _buildTextField("Valor M3", _valorM3Controller),
          const SizedBox(height: 16),
          const Text("Valor Total M3"),
          _buildTextField("Valor Total M3", _valorTotalM3Controller),
          const SizedBox(height: 16),
          Center(child: Icon(Icons.arrow_forward, size: 48)),
          const SizedBox(height: 16),
          _buildTextField("Diferencia", _diferenciaLecturasController),
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
    );
  }

  // Módulo de los 12 meses con valor pagado y estado de pago
  Widget _buildMesesPagados() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(12, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text("Mes ${index + 1}"),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField("Valor Pagado", TextEditingController()),
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
    );
  }

  // Módulo de pago
  Widget _buildModuloPago() {
    return Container(
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
    );
  }
}
