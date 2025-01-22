import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Medicamento {
  final String nome;
  final String descricao;
  final IconData icone;
  final String detalhada;
  final String tipo;

  Medicamento({
    required this.nome,
    required this.descricao,
    required this.icone,
    required this.detalhada,
    required this.tipo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
      'icone': icone.codePoint,
      'detalhada': detalhada,
      'tipo': tipo,
    };
  }

  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      nome: map['nome'],
      descricao: map['descricao'],
      icone: IconData(map['icone'], fontFamily: 'MaterialIcons'),
      detalhada: map['detalhada'],
      tipo: map['tipo'],
    );
  }
}

class ListMedicine extends StatefulWidget {
  @override
  _ListMedicineState createState() => _ListMedicineState();
}

class _ListMedicineState extends State<ListMedicine> {
  List<Medicamento> todosMedicamentos = [];
  List<Medicamento> medicamentosFiltrados = [];
  late String tipoMedicamento;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        tipoMedicamento = ModalRoute.of(context)!.settings.arguments as String;
      });
      _loadMedicamentos();
    });
  }

  _loadMedicamentos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedMedicamentos = prefs.getString('medicamentos');

    if (savedMedicamentos != null) {
      List<dynamic> decoded = json.decode(savedMedicamentos);
      setState(() {
        todosMedicamentos =
            decoded.map((item) => Medicamento.fromMap(item)).toList();
        medicamentosFiltrados = todosMedicamentos
            .where((med) => med.tipo == tipoMedicamento)
            .toList();
      });
    } else {
      setState(() {
        if (tipoMedicamento == 'A') {
          todosMedicamentos = [
            Medicamento(
              tipo: 'A',
              nome: 'Paracetamol',
              descricao: 'Antipirético e analgésico',
              detalhada:
                  'É um medicamento amplamente utilizado como analgésico para aliviar a dor e antitérmico para reduzir a febre.',
              icone: Icons.local_hospital,
            ),
            Medicamento(
              tipo: 'A',
              nome: 'Dipirona',
              descricao: 'Antipirético e analgésico',
              detalhada:
                  'É um analgésico e antitérmico amplamente utilizado no controle da dor e febre.',
              icone: Icons.local_hospital,
            ),
            Medicamento(
              tipo: 'A',
              nome: 'Loratadina',
              descricao: 'Antipirético',
              detalhada:
                  'Usado para aliviar sintomas de alergias, como rinite alérgica e urticária, sem causar sonolência significativa.',
              icone: Icons.local_hospital,
            ),
          ];
        } else if (tipoMedicamento == 'B') {
          todosMedicamentos = [
            Medicamento(
              tipo: 'B',
              nome: 'Omeprazol',
              descricao: 'Tratamento de problemas gástricos, como refluxo.',
              detalhada:
                  'É um medicamento da classe dos inibidores da bomba de prótons (IBPs) utilizado principalmente para tratar condições relacionadas ao excesso de ácido gástrico.',
              icone: Icons.medication,
            ),
            Medicamento(
              tipo: 'B',
              nome: 'Ibuprofeno',
              descricao: 'Anti-inflamatório e analgésico.',
              detalhada:
                  'É um medicamento da classe dos anti-inflamatórios não esteroides (AINEs), amplamente utilizado para aliviar dor, reduzir febre e combater inflamação.',
              icone: Icons.medication,
            ),
            Medicamento(
              tipo: 'B',
              nome: 'Cetoconazol',
              descricao: 'Antifúngico tópico ou oral.',
              detalhada:
                  'É um antifúngico usado no tratamento de infecções causadas por fungos, como candidíase, dermatite seborreica e micoses.',
              icone: Icons.medication,
            ),
          ];
        } else if (tipoMedicamento == 'C') {
          todosMedicamentos = [
            Medicamento(
              tipo: 'C',
              nome: 'Losartana',
              descricao: 'Antihipertensivo',
              detalhada:
                  'É um medicamento antihipertensivo, utilizado para tratar a hipertensão e prevenir complicações renais.',
              icone: Icons.medication,
            ),
            Medicamento(
              tipo: 'C',
              nome: 'Amoxicilina',
              descricao: 'Antibiótico',
              detalhada:
                  'É um antibiótico da classe das penicilinas, utilizado no tratamento de diversas infecções bacterianas.',
              icone: Icons.medication,
            ),
            Medicamento(
              tipo: 'C',
              nome: 'Diazepam',
              descricao:
                  'Benzodiazepínico usado como ansiolítico e relaxante muscular.',
              detalhada:
                  'É um ansiolítico e relaxante muscular da classe das benzodiazepinas, utilizado para tratar ansiedade, insônia e espasmos musculares.',
              icone: Icons.medication,
            ),
          ];
        } else if (tipoMedicamento == 'D') {
          todosMedicamentos = [
            Medicamento(
              tipo: 'D',
              nome: 'Clonazepam',
              descricao: 'Ansiolítico e anticonvulsivante.',
              detalhada:
                  'É um ansiolítico e anticonvulsivante da classe das benzodiazepinas, utilizado para tratar ansiedade, transtornos de pânico e epilepsia.',
              icone: Icons.medication,
            ),
            Medicamento(
              tipo: 'D',
              nome: 'Venvanse',
              descricao:
                  '(Lisdexanfetamina) - Estimulante usado no tratamento do TDAH.',
              detalhada:
                  'Estimulante do sistema nervoso central indicado para o tratamento do Transtorno de Déficit de Atenção e Hiperatividade (TDAH).',
              icone: Icons.medication,
            ),
            Medicamento(
              tipo: 'D',
              nome: 'Ritalina',
              descricao:
                  '(Metilfenidato) - Estimulante usado no tratamento do TDAH.',
              detalhada:
                  'É um estimulante do sistema nervoso central, usado no tratamento do Transtorno de Déficit de Atenção e Hiperatividade (TDAH) e narcolepsia.',
              icone: Icons.medication,
            ),
          ];
        }
        medicamentosFiltrados = todosMedicamentos;
      });
    }
  }

  _saveMedicamentos() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> mappedMedicamentos =
        todosMedicamentos.map((e) => e.toMap()).toList();
    String encodedMedicamentos = json.encode(mappedMedicamentos);
    prefs.setString('medicamentos', encodedMedicamentos);
  }

  String _getPageTitle(String tipo) {
    switch (tipo) {
      case 'A':
        return 'Sem Tarja: Medicamentos de baixo risco isentos de prescrição médica (MIPs)';
      case 'B':
        return 'Tarja Amarela: Medicamentos para venda sob prescrição médica, mas considerados de menor risco, com controle moderado';
      case 'C':
        return 'Tarja Vermelha: Medicamentos que exigem receita médica e são considerados de risco maior, porém não necessitam de retenção da receita';
      case 'D':
        return 'Tarja Preta: Medicamentos controlados que possuem potencial de causar dependência física ou psicológica, necessitam receita especial';
      default:
        return 'Medicamentos';
    }
  }

  void _addNewMedicine(BuildContext context) async {
    final newMedicine = await Navigator.pushNamed(
      context,
      '/add-medicine',
      arguments: tipoMedicamento,
    );
    if (newMedicine != null && newMedicine is Medicamento) {
      setState(() {
        todosMedicamentos.add(newMedicine);
        medicamentosFiltrados = todosMedicamentos
            .where((med) => med.tipo == tipoMedicamento)
            .toList();
      });
      _saveMedicamentos();
    }
  }

  void _showDetails(BuildContext context, Medicamento medicamento) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                medicamento.detalhada,
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
        title: Flexible(
          child: Text(
            _getPageTitle(tipoMedicamento),
            style: TextStyle(
                fontSize: 18), // Ajuste o tamanho da fonte se necessário
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
        backgroundColor: Colors.grey[600],
      ),
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        itemCount: medicamentosFiltrados.length,
        itemBuilder: (context, index) {
          final medicamento = medicamentosFiltrados[index];
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
                _showDetails(context, medicamento);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewMedicine(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[600],
      ),
    );
  }
}
