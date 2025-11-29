import 'dart:convert';

import 'package:algumacoisa/familiar/agenda_familiar.dart';
import 'package:algumacoisa/familiar/consultas_familiar.dart';
import 'package:algumacoisa/familiar/conversas_familiar.dart';
import 'package:algumacoisa/familiar/emergencias_familiar.dart';
import 'package:algumacoisa/familiar/medicamentos_familiar.dart';
import 'package:algumacoisa/familiar/meu_perfil_screen.dart';
import 'package:algumacoisa/familiar/notificacoes_screen.dart';
import 'package:algumacoisa/familiar/sentimentos_familiar.dart';
import 'package:algumacoisa/familiar/tarefas_familiar.dart';
import 'package:flutter/material.dart';
import 'package:algumacoisa/dio_client.dart' as http;

import '../config.dart';

class HomeFamiliar extends StatefulWidget {
  const HomeFamiliar({super.key});

  @override
  _HomeFamiliarState createState() => _HomeFamiliarState();
}

class _HomeFamiliarState extends State<HomeFamiliar> {
  Map<String, dynamic> _perfilData = {};
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _carregarPerfil();
  }

  Future<void> _carregarPerfil() async {
    try {
      final response = await http
          .get(Uri.parse('${Config.apiUrl}/api/familiar/perfil'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        setState(() {
          _perfilData = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Erro ao carregar perfil: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage =
            'Erro de conexão: $error\n\nVerifique:\n1. Se o servidor está rodando\n2. Se a URL está correta\n3. Sua conexão com a internet';
        _isLoading = false;
      });
    }
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

  void _navegarParaPerfil(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MeuPerfilfamiliar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nomeUsuario = _perfilData['nome']?.split(' ').first ?? 'Usuário';
    final inicial = _getInicial(nomeUsuario);
    final avatarColor = _getAvatarColor(inicial);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // ← ADICIONE ESTA LINHA
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 106, 186, 213),
                const Color.fromARGB(255, 106, 186, 213),
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
                  onTap: () => _navegarParaPerfil(context),
                  child: Row(
                    children: [
                      // Avatar com letra inicial
                      if (_isLoading)
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[300],
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      else if (_errorMessage.isNotEmpty)
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.error, color: Colors.white),
                        )
                      else
                        CircleAvatar(
                          backgroundColor: avatarColor,
                          radius: 24,
                          child: Text(
                            inicial,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      const SizedBox(width: 12),
                      // Nome com loading
                      if (_isLoading)
                        const Text(
                          'Carregando...',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      else if (_errorMessage.isNotEmpty)
                        const Text(
                          'Erro ao carregar',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      else
                        Text(
                          'Bem-vindo, $nomeUsuario',
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
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificacoesFamiliar(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildInfoCard(
              icon: Icons.access_time,
              title: 'Consultas Hoje',
              subtitle: '2 Agendadas',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultasFamiliar()),
                );
              },
            ),
            _buildInfoCard(
              icon: Icons.medical_services_outlined,
              title: 'Medicamentos a administrar',
              subtitle: '2 Horários',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicamentosFamiliar(),
                  ),
                );
              },
            ),
            _buildInfoCard(
              icon: Icons.warning_amber_outlined,
              title: 'Emergências recentes',
              subtitle: '1 Alerta hoje',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergenciasScreen()),
                );
              },
            ),
            _buildInfoCard(
              icon: Icons.task_alt,
              title: 'Tarefas Pendentes',
              subtitle: '2 Tarefas',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TarefasFamiliar()),
                );
              },
            ),
            _buildInfoCard(
              icon: Icons.sick_outlined,
              title: 'Sentimentos Paciente',
              subtitle: '2 sintomas hoje',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SentimentosFamiliar(),
                  ),
                );
              },
            ),

            // Botão para recarregar em caso de erro
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _carregarPerfil,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              106,
                              186,
                              213,
                            ),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Tentar Novamente'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Color.fromARGB(255, 106, 186, 213),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.message_outlined,
                color: Color.fromARGB(255, 106, 186, 213),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConversasFamiliar()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: Color.fromARGB(255, 106, 186, 213),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgendaFamiliar()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
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
              Icon(
                icon,
                size: 40,
                color: const Color.fromARGB(255, 106, 186, 213),
              ),
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
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
