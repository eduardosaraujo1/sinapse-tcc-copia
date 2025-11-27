import 'package:algumacoisa/cuidador/home_cuidador_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<dynamic> _pacientesComConsultas = [];
  List<dynamic> _pacientesComMedicamentos = [];
  List<dynamic> _pacientesComTarefas = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Buscar dados de todas as APIs simultaneamente
      final responses = await Future.wait([
        http.get(Uri.parse('http://localhost:8000/api/cuidador/PacienteComConsulta')),
        http.get(Uri.parse('http://localhost:8000/api/cuidador/PacienteComMedicamentos')),
        http.get(Uri.parse('http://localhost:8000/api/cuidador/PacienteComTarefas')),
      ]);

      // Processar cada resposta
      for (int i = 0; i < responses.length; i++) {
        final response = responses[i];
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['success'] == true) {
            setState(() {
              switch (i) {
                case 0:
                  _pacientesComConsultas = data['data'];
                  break;
                case 1:
                  _pacientesComMedicamentos = data['data'];
                  break;
                case 2:
                  _pacientesComTarefas = data['data'];
                  break;
              }
            });
          }
        } else {
          throw Exception('Erro ao carregar dados da API ${i + 1}');
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao carregar notificações: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Função para formatar a data
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day} ${_getMonthName(date.month)}';
    } catch (e) {
      return dateString;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN',
      'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ'
    ];
    return months[month - 1];
  }

  // Função para calcular dias restantes
  String _calculateDaysLeft(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = date.difference(now);
      final days = difference.inDays;
      
      if (days == 0) return 'Hoje!';
      if (days == 1) return 'Falta 1 dia!';
      if (days > 1) return 'Faltam $days dias!';
      if (days == -1) return 'Há 1 dia';
      if (days < -1) return 'Há ${days.abs()} dias';
      
      return 'Data inválida';
    } catch (e) {
      return 'Data inválida';
    }
  }

  // Função para determinar cor do status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pendente':
        return Colors.orange;
      case 'concluído':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      case 'atrasado':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeCuidadorScreen()),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
            ],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        
                        // Consultas
                        if (_pacientesComConsultas.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Consultas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          ..._buildConsultasCards(),
                          const SizedBox(height: 16),
                        ],
                        
                        // Medicamentos
                        if (_pacientesComMedicamentos.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Medicamentos',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          ..._buildMedicamentosCards(),
                          const SizedBox(height: 16),
                        ],
                        
                        // Tarefas
                        if (_pacientesComTarefas.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Tarefas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          ..._buildTarefasCards(),
                        ],
                        
                        // Mensagem se não houver dados
                        if (_pacientesComConsultas.isEmpty &&
                            _pacientesComMedicamentos.isEmpty &&
                            _pacientesComTarefas.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text(
                              'Nenhuma notificação encontrada',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
      ),
    );
  }

  List<Widget> _buildConsultasCards() {
    List<Widget> cards = [];
    
    for (var paciente in _pacientesComConsultas) {
      for (var consulta in paciente['consultas']) {
        cards.add(
          _buildNotificationCard(
            _formatDate(consulta['hora_consulta']),
            'Consulta: ${consulta['especialidade']}',
            'Paciente: ${paciente['nome']} - ${consulta['medico_nome']}',
            consulta['local_consulta'] ?? consulta['endereco_consulta'] ?? '',
            _calculateDaysLeft(consulta['hora_consulta']),
            _getStatusColor(consulta['status']),
            Icons.medical_services,
          ),
        );
        cards.add(const SizedBox(height: 12));
      }
    }
    
    return cards;
  }

  List<Widget> _buildMedicamentosCards() {
    List<Widget> cards = [];
    
    for (var paciente in _pacientesComMedicamentos) {
      for (var medicamento in paciente['medicamentos']) {
        cards.add(
          _buildNotificationCard(
            _formatDate(medicamento['data_hora']),
            'Medicação: ${medicamento['medicamento_nome']}',
            'Paciente: ${paciente['nome']} - ${medicamento['dosagem']}',
            'Horário: ${DateTime.parse(medicamento['data_hora']).hour.toString().padLeft(2, '0')}:${DateTime.parse(medicamento['data_hora']).minute.toString().padLeft(2, '0')}',
            _calculateDaysLeft(medicamento['data_hora']),
            _getStatusColor(medicamento['status']),
            Icons.medication,
          ),
        );
        cards.add(const SizedBox(height: 12));
      }
    }
    
    return cards;
  }

  List<Widget> _buildTarefasCards() {
    List<Widget> cards = [];
    
    for (var paciente in _pacientesComTarefas) {
      for (var tarefa in paciente['tarefas']) {
        cards.add(
          _buildNotificationCard(
            _formatDate(tarefa['data_tarefa']),
            'Tarefa: ${tarefa['motivacao']}',
            'Paciente: ${paciente['nome']}',
            tarefa['descricao'] ?? '',
            _calculateDaysLeft(tarefa['data_tarefa']),
            _getStatusColor(tarefa['status']),
            Icons.task,
          ),
        );
        cards.add(const SizedBox(height: 12));
      }
    }
    
    return cards;
  }

  Widget _buildNotificationCard(
    String date,
    String title,
    String subtitle,
    String description,
    String status,
    Color statusColor,
    IconData icon,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE1F5FE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.split(' ')[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6ABAD5),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    date.split(' ')[1],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6ABAD5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}