import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MedicamentosScreen extends StatefulWidget {
  const MedicamentosScreen({super.key});

  @override
  State<MedicamentosScreen> createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<MedicamentosScreen> {
  List<dynamic> pacientes = [];
  List<dynamic> pacientesFiltrados = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _carregarPacientesComMedicamentos();
  }

  Future<void> _carregarPacientesComMedicamentos() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/api/cuidador/PacienteComMedicamentos'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            pacientes = data['data'];
            pacientesFiltrados = pacientes;
            isLoading = false;
          });
        }
      } else {
        throw Exception('Falha ao carregar dados');
      }
    } catch (error) {
      print('Erro: $error');
      setState(() {
        isLoading = false;
      });
      _mostrarErroSnackbar('Erro ao carregar medicamentos');
    }
  }

  // Função para atualizar status do medicamento
  Future<void> _atualizarStatusMedicamento(String id, String status) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:8000/api/medicamento/$id/status'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': status}),
      );
      
      if (response.statusCode == 200) {
        _carregarPacientesComMedicamentos(); // Recarrega os dados
        _mostrarSucessoSnackbar('Status atualizado com sucesso!');
      } else {
        throw Exception('Falha ao atualizar status');
      }
    } catch (error) {
      _mostrarErroSnackbar('Erro ao atualizar status');
    }
  }

  void _filtrarPacientes(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        pacientesFiltrados = pacientes;
      } else {
        pacientesFiltrados = pacientes.where((paciente) {
          final nome = paciente['nome'].toString().toLowerCase();
          final medicamentos = paciente['medicamentos'] ?? [];
          
          final temMedicamentoComNome = medicamentos.any((med) => 
              med['medicamento_nome'].toString().toLowerCase().contains(query.toLowerCase()));
          
          return nome.contains(query.toLowerCase()) || temMedicamentoComNome;
        }).toList();
      }
    });
  }

  void _mostrarErroSnackbar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _mostrarSucessoSnackbar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _formatarDataHora(String dataHora) {
    try {
      final dateTime = DateTime.parse(dataHora);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dataHora;
    }
  }

  String _formatarStatus(String status) {
    switch (status) {
      case 'pendente':
        return 'Pendente';
      case 'feita':
        return 'Administrado';
      case 'atrasada':
        return 'Atrasado';
      case 'cancelada':
        return 'Cancelado';
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pendente':
        return Colors.orange;
      case 'feita':
        return Colors.green;
      case 'atrasada':
        return Colors.red;
      case 'cancelada':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getInicial(String nome) {
    if (nome.isEmpty) return '?';
    return nome[0].toUpperCase();
  }

  Color _getAvatarColor(String letra) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
    ];
    
    if (letra.isEmpty || letra == '?') return const Color.fromARGB(255, 0, 0, 0);
    final index = letra.codeUnitAt(0) % colors.length;
    return colors[index];
  }

  // Diálogo para escolher status
  void _mostrarDialogoStatusMedicamento(dynamic medicamento) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alterar Status'),
          content: Text('Medicamento: ${medicamento['medicamento_nome']}'),
          actions: [
            _buildBotaoStatus('pendente', 'Pendente', medicamento),
            _buildBotaoStatus('feita', 'Administrado', medicamento),
            _buildBotaoStatus('atrasada', 'Atrasado', medicamento),
            _buildBotaoStatus('cancelada', 'Cancelado', medicamento),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBotaoStatus(String status, String label, dynamic medicamento) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        _atualizarStatusMedicamento(medicamento['id'].toString(), status);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Medicamentos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: isLoading ? null : _carregarPacientesComMedicamentos,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: _filtrarPacientes,
              decoration: InputDecoration(
                hintText: 'Buscar pacientes ou medicamentos',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            if (isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (pacientesFiltrados.isEmpty && searchQuery.isNotEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Nenhum paciente encontrado para "$searchQuery"',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else if (pacientesFiltrados.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.medication, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Nenhum paciente com medicamentos cadastrado',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _carregarPacientesComMedicamentos,
                  child: ListView.builder(
                    itemCount: pacientesFiltrados.length,
                    itemBuilder: (context, index) {
                      final paciente = pacientesFiltrados[index];
                      final medicamentos = paciente['medicamentos'] ?? [];
                      return _buildPacienteCard(context, paciente, medicamentos);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPacienteCard(BuildContext context, dynamic paciente, List<dynamic> medicamentos) {
    final inicial = _getInicial(paciente['nome'] ?? '');
    final avatarColor = _getAvatarColor(inicial);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: avatarColor,
                  radius: 25,
                  child: Text(
                    inicial,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paciente['nome'] ?? 'Nome não informado',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (paciente['idade'] != null)
                        Text(
                          '${paciente['idade']} anos',
                          style: TextStyle(color: Colors.grey),
                        ),
                      if (paciente['comorbidade'] != null)
                        Text(
                          paciente['comorbidade'] ?? '',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (medicamentos.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Nenhum medicamento cadastrado',
                  style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medicamentos:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  ...medicamentos.map((medicamento) => _buildMedicamentoItem(medicamento)).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicamentoItem(dynamic medicamento) {
    final status = medicamento['status'] ?? 'pendente';
    
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 1,
      color: _getStatusColor(status).withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.medication, color: _getStatusColor(status)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicamento['medicamento_nome'] ?? 'Medicamento não informado',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Dosagem: ${medicamento['dosagem'] ?? 'Não informada'}',
                    style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Text(
                    'Data: ${_formatarDataHora(medicamento['data_hora'])}',
                    style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _getStatusColor(status)),
                  ),
                  child: Text(
                    _formatarStatus(status),
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                IconButton(
                  icon: Icon(Icons.edit, size: 18),
                  onPressed: () => _mostrarDialogoStatusMedicamento(medicamento),
                  tooltip: 'Alterar status',
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}