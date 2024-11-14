import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MedicamentosPage(),
    );
  }
}

class Medicamento {
  final String nome;
  final String descricao;
  final IconData icone;
  final String detalhada;

  Medicamento({
    required this.nome,
    required this.descricao,
    required this.icone,
    required this.detalhada,
  });
}

class MedicamentosPage extends StatelessWidget {
  final List<Medicamento> medicamentos = [
    Medicamento(
        nome: 'Paracetamol',
        descricao: 'Antipirético e analgésico',
        icone: Icons.local_hospital,
        detalhada:
            'É um medicamento amplamente utilizado como analgésico para aliviar a dor e antitérmico para reduzir a febre.'),
    Medicamento(
        nome: 'Ibuprofeno',
        descricao: 'Anti-inflamatório e analgésico',
        icone: Icons.healing,
        detalhada:
            'É um medicamento da classe dos anti-inflamatórios não esteroides (AINEs), amplamente utilizado para aliviar dor, reduzir febre e combater inflamação.'),
    Medicamento(
        nome: 'Amoxicilina',
        descricao: 'Antibiótico',
        icone: Icons.health_and_safety,
        detalhada:
            'É um antibiótico da classe das penicilinas, utilizado no tratamento de diversas infecções bacterianas.'),
    Medicamento(
        nome: 'Dipirona',
        descricao: 'Antipirético e analgésico',
        icone: Icons.medical_services,
        detalhada:
            'É um analgésico e antitérmico amplamente utilizado no controle da dor e febre.'),
    Medicamento(
        nome: 'Omeprazol',
        descricao: 'Inibidor da bomba de prótons',
        icone: Icons.health_and_safety,
        detalhada:
            'É um medicamento da classe dos inibidores da bomba de prótons (IBPs) utilizado principalmente para tratar condições relacionadas ao excesso de ácido gástrico.'),
  ];

  void _showDetails(BuildContext context, Medicamento medicamento) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicamento.nome,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                medicamento.descricao,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Text(
                'Descrição Detalhada:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                medicamento.detalhada,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Text(
                'Instruções de Uso:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Tomar uma dose de 500mg a cada 6 horas. Não exceder a dose recomendada.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Medicamentos'),
      ),
      body: ListView.builder(
        itemCount: medicamentos.length,
        itemBuilder: (context, index) {
          final medicamento = medicamentos[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Icon(medicamento.icone, size: 40, color: Colors.blue),
              title: Text(
                medicamento.nome,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                medicamento.descricao,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Ao clicar no medicamento, mostra os detalhes na tela
                _showDetails(context, medicamento);
              },
            ),
          );
        },
      ),
    );
  }
}
