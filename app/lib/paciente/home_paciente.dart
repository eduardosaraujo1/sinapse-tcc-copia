import 'package:algumacoisa/paciente/notificacoes_screen.dart';
import 'package:flutter/material.dart';
import 'package:algumacoisa/paciente/agenda_paciente.dart';
import 'package:algumacoisa/paciente/emergencia_paciente.dart';
import 'package:algumacoisa/paciente/mensagems_paciente.dart';
import 'package:algumacoisa/paciente/perfil_paciente.dart';
import 'package:algumacoisa/paciente/sentimentos_paciente.dart';
import 'package:algumacoisa/dio_client.dart' as http;
import 'dart:convert';

import '../config.dart';

class HomePaciente extends StatefulWidget {
  const HomePaciente({super.key});

  @override
  _HomePacienteState createState() => _HomePacienteState();
}

class _HomePacienteState extends State<HomePaciente> {
  int _selectedIndex = 2;
  Map<String, dynamic> _pacienteData = {};
  List<dynamic> _consultas = [];
  List<dynamic> _medicamentos = [];
  List<dynamic> _tarefas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosPaciente();
    _carregarAtribuicoes();
  }

  // Função para obter cor baseada no status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'feita':
        return Colors.green;
      case 'atrasada':
        return Colors.red;
      case 'pendente':
        return Colors.orange;
      case 'cancelada':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  // Função para obter ícone baseado no status
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'feita':
        return Icons.check_circle;
      case 'atrasada':
        return Icons.warning;
      case 'pendente':
        return Icons.access_time;
      case 'cancelada':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  // Função para obter texto do status
  String _getStatusText(String status) {
    switch (status) {
      case 'feita':
        return 'Concluída';
      case 'atrasada':
        return 'Atrasada';
      case 'pendente':
        return 'Pendente';
      case 'cancelada':
        return 'Cancelada';
      default:
        return 'Desconhecido';
    }
  }

  // Função para marcar como feito
  Future<void> _marcarComoFeito(String tipo, String id) async {
    try {
      String endpoint = '';

      switch (tipo) {
        case 'consulta':
          endpoint = '${Config.apiUrl}/api/consulta/$id/status';
          break;
        case 'medicamento':
          endpoint = '${Config.apiUrl}/api/medicamento/$id/status';
          break;
        case 'tarefa':
          endpoint = '${Config.apiUrl}/api/tarefa/$id/status';
          break;
      }

      final response = await http.put(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': 'feita'}),
      );

      if (response.statusCode == 200) {
        print('✅ $tipo marcado como feito');
        // Recarregar os dados
        _carregarAtribuicoes();

        // Mostrar snackbar de confirmação
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$tipo marcado como concluído!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Erro ao atualizar status');
      }
    } catch (error) {
      print('❌ Erro ao marcar como feito: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao marcar como concluído: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _carregarDadosPaciente() async {
    try {
      print('🔍 Iniciando requisição para a API...');
      final response = await http.get(
        Uri.parse('${Config.apiUrl}/api/paciente/perfil'),
      );

      print('📊 Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('✅ Dados recebidos da API: $data');

        setState(() {
          _pacienteData = data;
        });
      } else {
        print('❌ Erro na API - Status: ${response.statusCode}');
        _usarDadosPadrao();
      }
    } catch (error) {
      print('💥 Erro na requisição: $error');
      _usarDadosPadrao();
    }
  }

  Future<void> _carregarAtribuicoes() async {
    try {
      print('📋 Carregando atribuições do paciente...');

      // Carregar consultas
      final consultasResponse = await http.get(
        Uri.parse('${Config.apiUrl}/api/cuidador/PacienteComConsulta'),
      );
      if (consultasResponse.statusCode == 200) {
        final consultasData = json.decode(consultasResponse.body);
        setState(() {
          _consultas = consultasData['data'] ?? [];
        });
        print('✅ Consultas carregadas: ${_consultas.length}');
      }

      // Carregar medicamentos
      final medicamentosResponse = await http.get(
        Uri.parse('${Config.apiUrl}/api/cuidador/PacienteComMedicamentos'),
      );
      if (medicamentosResponse.statusCode == 200) {
        final medicamentosData = json.decode(medicamentosResponse.body);
        setState(() {
          _medicamentos = medicamentosData['data'] ?? [];
        });
        print('✅ Medicamentos carregados: ${_medicamentos.length}');
      }

      // Carregar tarefas
      final tarefasResponse = await http.get(
        Uri.parse('${Config.apiUrl}/api/cuidador/PacienteComTarefas'),
      );
      if (tarefasResponse.statusCode == 200) {
        final tarefasData = json.decode(tarefasResponse.body);
        setState(() {
          _tarefas = tarefasData['data'] ?? [];
        });
        print('✅ Tarefas carregadas: ${_tarefas.length}');
      }

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('💥 Erro ao carregar atribuições: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _usarDadosPadrao() {
    print('🔄 Usando dados padrão...');
    setState(() {
      _pacienteData = {'nome': 'Paulo', 'foto_url': 'assets/Paulosikera.jpg'};
    });
  }

  // Função para obter a letra inicial do nome
  String _getInicial(String nome) {
    if (nome.isEmpty) return '?';
    return nome[0].toUpperCase();
  }

  // Função para gerar uma cor baseada na letra inicial
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

    if (letra.isEmpty || letra == '?') return Colors.grey;

    final index = letra.codeUnitAt(0) % colors.length;
    return colors[index];
  }

  // Função para formatar data/hora
  String _formatarDataHora(String dataHora) {
    try {
      DateTime dateTime = DateTime.parse(dataHora);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dataHora;
    }
  }

  // Função para obter consultas de hoje
  List<dynamic> _getConsultasDeHoje() {
    final hoje = DateTime.now();
    return _consultas.expand((paciente) => paciente['consultas'] ?? []).where((
      consulta,
    ) {
      if (consulta['hora_consulta'] == null) return false;
      try {
        final dataConsulta = DateTime.parse(consulta['hora_consulta']);
        return dataConsulta.year == hoje.year &&
            dataConsulta.month == hoje.month &&
            dataConsulta.day == hoje.day;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  // Função para obter medicamentos de hoje
  List<dynamic> _getMedicamentosDeHoje() {
    final hoje = DateTime.now();
    return _medicamentos
        .expand((paciente) => paciente['medicamentos'] ?? [])
        .where((medicamento) {
          if (medicamento['data_hora'] == null) return false;
          try {
            final dataMedicamento = DateTime.parse(medicamento['data_hora']);
            return dataMedicamento.year == hoje.year &&
                dataMedicamento.month == hoje.month &&
                dataMedicamento.day == hoje.day;
          } catch (e) {
            return false;
          }
        })
        .toList();
  }

  // Função para obter tarefas de hoje
  List<dynamic> _getTarefasDeHoje() {
    final hoje = DateTime.now();
    return _tarefas.expand((paciente) => paciente['tarefas'] ?? []).where((
      tarefa,
    ) {
      if (tarefa['data_tarefa'] == null) return false;
      try {
        final dataTarefa = DateTime.parse(tarefa['data_tarefa']);
        return dataTarefa.year == hoje.year &&
            dataTarefa.month == hoje.month &&
            dataTarefa.day == hoje.day;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AgendaPaciente()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MensagemsPaciente()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SentimentosPaciente()),
        );
        break;
    }
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tem certeza de que deseja enviar um alerta de emergência?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmergenciaPaciente(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'SIM, PRECISO DE AJUDA',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'CANCELAR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final consultasDeHoje = _getConsultasDeHoje();
    final medicamentosDeHoje = _getMedicamentosDeHoje();
    final tarefasDeHoje = _getTarefasDeHoje();
    final nomeCompleto = _pacienteData['nome'] ?? 'Paciente';
    final inicial = _getInicial(nomeCompleto);
    final avatarColor = _getAvatarColor(inicial);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(avatarColor, inicial),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildInfoCard(
              context: context,
              icon: Icons.warning_amber_outlined,
              title: 'Emergência',
              subtitle: 'Clique para pedir ajuda',
              iconColor: Colors.red,
              onTap: _showEmergencyDialog,
            ),
            const SizedBox(height: 20),
            const Text(
              'Hoje:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Exibir tarefas de hoje
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              // Tarefas
              for (final tarefa in tarefasDeHoje)
                _buildInfoCardComStatus(
                  context: context,
                  icon: Icons.task_alt,
                  title: tarefa['motivacao'] ?? 'Tarefa',
                  subtitle: tarefa['descricao'] ?? 'Descrição não disponível',
                  iconColor: const Color.fromARGB(255, 106, 186, 213),
                  status: tarefa['status'] ?? 'pendente',
                  tipo: 'tarefa',
                  id: tarefa['id'].toString(),
                  onTap: () {},
                ),

              // Medicamentos
              for (final medicamento in medicamentosDeHoje)
                _buildInfoCardComStatus(
                  context: context,
                  icon: Icons.medical_services_outlined,
                  title: medicamento['medicamento_nome'] ?? 'Medicamento',
                  subtitle:
                      '${medicamento['dosagem'] ?? 'Dosagem não informada'} - ${_formatarDataHora(medicamento['data_hora'] ?? '')}',
                  iconColor: const Color.fromARGB(255, 106, 186, 213),
                  status: medicamento['status'] ?? 'pendente',
                  tipo: 'medicamento',
                  id: medicamento['id'].toString(),
                  onTap: () {},
                ),

              // Consultas
              for (final consulta in consultasDeHoje)
                _buildInfoCardComStatus(
                  context: context,
                  icon: Icons.person_pin_outlined,
                  title: consulta['especialidade'] ?? 'Consulta',
                  subtitle:
                      '${consulta['medico_nome'] ?? 'Médico'} - ${_formatarDataHora(consulta['hora_consulta'] ?? '')}',
                  iconColor: const Color.fromARGB(255, 106, 186, 213),
                  status: consulta['status'] ?? 'pendente',
                  tipo: 'consulta',
                  id: consulta['id'].toString(),
                  onTap: () {},
                ),

              // Mensagem quando não há atribuições
              if (tarefasDeHoje.isEmpty &&
                  medicamentosDeHoje.isEmpty &&
                  consultasDeHoje.isEmpty)
                _buildInfoCard(
                  context: context,
                  icon: Icons.check_circle_outline,
                  title: 'Nenhuma atividade para hoje',
                  subtitle: 'Aproveite para descansar!',
                  iconColor: Colors.green,
                  onTap: () {},
                ),
            ],

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar(Color avatarColor, String inicial) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: const Color.fromARGB(0, 25, 190, 25),
      elevation: 0,
      automaticallyImplyLeading: false, // ← LINHA ADICIONADA AQUI
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 106, 186, 213),
              Color.fromARGB(255, 106, 186, 213),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PerfilPaciente()),
                  );
                },
                child: Row(
                  children: [
                    // Avatar com inicial do nome
                    CircleAvatar(
                      backgroundColor: avatarColor,
                      radius: 24,
                      child: Text(
                        inicial,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Bem-vindo, ${_pacienteData['nome'] ?? 'Paciente'}.',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notificacoes()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: iconColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCardComStatus({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required String status,
    required String tipo,
    required String id,
    VoidCallback? onTap,
  }) {
    final statusColor = _getStatusColor(status);
    final statusIcon = _getStatusIcon(status);
    final statusText = _getStatusText(status);
    final podeMarcarComoFeito = status != 'feita' && status != 'cancelada';

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: iconColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                    const SizedBox(height: 8),
                    // Badge de status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: statusColor),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 14, color: statusColor),
                          const SizedBox(width: 4),
                          Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Botão para marcar como feito
              if (podeMarcarComoFeito)
                IconButton(
                  icon: Icon(Icons.check_circle_outline, color: Colors.green),
                  onPressed: () => _marcarComoFeito(tipo, id),
                  tooltip: 'Marcar como concluído',
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: _selectedIndex == 0
                  ? const Color.fromARGB(255, 106, 186, 213)
                  : Colors.grey,
            ),
            onPressed: () => _onItemTapped(0),
          ),
          IconButton(
            icon: Icon(
              Icons.mail_outline,
              color: _selectedIndex == 1
                  ? const Color.fromARGB(255, 106, 186, 213)
                  : Colors.grey,
            ),
            onPressed: () => _onItemTapped(1),
          ),
          IconButton(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 2
                  ? const Color.fromARGB(255, 106, 186, 213)
                  : Colors.grey,
            ),
            onPressed: () => _onItemTapped(2),
          ),
          IconButton(
            icon: Icon(
              Icons.sentiment_satisfied_outlined,
              color: _selectedIndex == 3
                  ? const Color.fromARGB(255, 106, 186, 213)
                  : Colors.grey,
            ),
            onPressed: () => _onItemTapped(3),
          ),
          IconButton(
            icon: Icon(
              Icons.sick_outlined,
              color: _selectedIndex == 4
                  ? const Color.fromARGB(255, 106, 186, 213)
                  : Colors.grey,
            ),
            onPressed: () => _onItemTapped(4),
          ),
        ],
      ),
    );
  }
}
