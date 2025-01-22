import 'package:flutter/material.dart';
import 'list_medicine.dart';

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _detalhadaController = TextEditingController();

  late String tipo; // Armazena o tipo recebido

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtém o tipo passado como argumento
    final String? receivedTipo =
        ModalRoute.of(context)?.settings.arguments as String?;
    if (receivedTipo == null) {
      // Adicione uma validação para garantir que o tipo não seja null
      throw Exception("O tipo do medicamento não foi passado corretamente.");
    }
    tipo = receivedTipo;
  }

  void _saveMedicine(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final newMedicine = Medicamento(
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        icone: Icons.medical_services,
        detalhada: _detalhadaController.text,
        tipo: tipo, // Usa o tipo recebido
      );
      Navigator.pop(context, newMedicine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Adicionar Medicamento'),
        ),
        backgroundColor: Colors.grey[600],
      ),
      backgroundColor: Colors.grey[300], // Define a cor de fundo da tela
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do medicamento.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a descrição do medicamento.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _detalhadaController,
                decoration: InputDecoration(labelText: 'Descrição Detalhada'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a descrição detalhada do medicamento.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _saveMedicine(context),
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
