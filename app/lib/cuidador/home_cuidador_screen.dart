import 'package:flutter/material.dart';
import 'dart:convert'; // Para decodificar a resposta JSON
import 'package:http/http.dart' as http; // Biblioteca HTTP
import 'package:algumacoisa/cuidador/agenda_cuidador.dart';
import 'package:algumacoisa/cuidador/selecionar_paciente_screen.dart';
import 'consultas_screen.dart';
import 'medicamentos_screen.dart';
import 'emergencias_screen.dart';
import 'tarefas_screen.dart';
import 'sentimentos_screen.dart';
import 'pacientes_screen.dart';
import 'meu_perfil_screen.dart';
import 'conversas_screen.dart';
import 'agendar_consultas_screen.dart';
import 'agendar_medicamento_screen.dart';
import 'agendar_tarefa_screen.dart' hide AgendarConsultasScreen, PacientesScreen, ConversasScreen, MeuPerfilScreen;
import 'notifications_screen.dart';
import 'meu_perfil_screen.dart';

// Constante de cor primária e espaçamento para FABs
const Color _primaryColor = Color.fromARGB(255, 106, 186, 213);
const double _fabSpacing = 75.0; 

// --- Modelo de Dados ---
class CuidadorPerfil {
  final String nome;

  CuidadorPerfil({required this.nome});

  factory CuidadorPerfil.fromJson(Map<String, dynamic> json) {
    return CuidadorPerfil(
      // Assume que a API retorna 'nome'. Se for nulo, usa um fallback.
      nome: json['nome'] ?? 'Nome Desconhecido', 
    );
  }
}

class HomeCuidadorScreen extends StatefulWidget {
  const HomeCuidadorScreen({super.key});

  @override
  _HomeCuidadorScreenState createState() => _HomeCuidadorScreenState();
}

class _HomeCuidadorScreenState extends State<HomeCuidadorScreen> {
  bool _showOptions = false;
  String _caregiverName = 'Cuidador(a)'; // Nome padrão
  bool _isLoading = true;
  bool _hasError = false;

  // URL da API local fornecida
  final String apiUrl = 'http://localhost:8000/api/cuidador/perfil';

  @override
  void initState() {
    super.initState();
    _fetchCaregiverProfile();
  }

  // --- Função para buscar o perfil do cuidador na API ---
  Future<void> _fetchCaregiverProfile() async {
    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profile = CuidadorPerfil.fromJson(jsonResponse);
        
        // Pega apenas o primeiro nome para uma saudação concisa
        final firstName = profile.nome.split(' ').first; 
        setState(() {
          _caregiverName = firstName;
          _isLoading = false;
        });
      } else {
        // Trata erro de status HTTP (ex: 404, 500)
        _handleFetchError('Falha ao carregar perfil: Status ${response.statusCode}');
      }
    } catch (e) {
  
      _handleFetchError('Erro de conexão ou timeout: $e');
    }
  }

  void _handleFetchError(String message) {
     if (mounted) {
      setState(() {
        _caregiverName = 'Usuário'; // Fallback amigável
        _isLoading = false;
        _hasError = true;
      });
      debugPrint(message);
    }
  }

  // Função para obter a letra inicial do nome
  String _getInitialLetter() {
    if (_caregiverName.isEmpty || _caregiverName == 'Usuário') {
      return 'U';
    }
    return _caregiverName[0].toUpperCase();
  }

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determina a mensagem de boas-vindas
    String welcomeMessage;
    if (_isLoading) {
      // Se ainda estiver carregando, mostre "Carregando..."
      welcomeMessage = 'Carregando...';
    } else {
      // Se já carregou (com sucesso ou falha), mostre a saudação.
      // Se falhou, o _caregiverName já será o fallback ('Cuidador(a)' ou 'Usuário').
      welcomeMessage = 'Bem-vindo, $_caregiverName';
    }

    return Scaffold(
    appBar: AppBar(
  toolbarHeight: 100,
  backgroundColor: Colors.transparent,
  elevation: 0,
  automaticallyImplyLeading: false, // ← ADICIONE ESTA LINHA
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_primaryColor, _primaryColor],
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
                      MaterialPageRoute(builder: (context) => MeuPerfilScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      // CircleAvatar com a letra inicial do cuidador
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        child: Text(
                          _getInitialLetter(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Exibe o nome dinâmico ou a mensagem de carregamento/erro
                      Text(
                        welcomeMessage,
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
                      MaterialPageRoute(builder: (context) => NotificationsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // --- Corpo da Tela (Conteúdo Fixo) ---
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                // Cards de Resumo
                _buildInfoCard(
                  context: context,
                  icon: Icons.access_time,
                  title: 'Consultas Hoje',
                  subtitle: 'Clique para vizualizar',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultasScreen()));
                  },
                ),
                _buildInfoCard(
                  context: context,
                  icon: Icons.medical_services_outlined,
                  title: 'Medicamentos a administrar',
                  subtitle: 'Clique para vizualizar',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MedicamentosScreen()));
                  },
                ),
                _buildInfoCard(
                  context: context,
                  icon: Icons.warning_amber_outlined,
                  title: 'Emergências recentes',
                  subtitle: 'Clique para vizualizar',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmergenciasScreen()));
                  },
                ),
                _buildInfoCard(
                  context: context,
                  icon: Icons.task_alt,
                  title: 'Tarefas Pendentes',
                  subtitle: 'Clique para vizualizar',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TarefasScreen()));
                  },
                ),
                _buildInfoCard(
                  context: context,
                  icon: Icons.sick_outlined,
                  title: 'Sentimentos Paciente',
                  subtitle: 'Clique para vizualizar',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SentimentosScreen()));
                  },
                ),
              ],
            ),
          ),

          // --- Menu Flutuante de Opções de Agendamento ---
         Positioned(
            bottom: 80,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAnimatedFloatingButton(
                  icon: Icons.medication_outlined,
                  isVisible: _showOptions,
                  offset: 10,
                  onPressed: () {
                    _toggleOptions();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AgendarMedicamentoScreen()),
                    );
                  },
                ),
                _buildAnimatedFloatingButton(
                  icon: Icons.task_alt,
                  isVisible: _showOptions,
                  offset: 00.0,
                  onPressed: () {
                    _toggleOptions();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AgendarTarefaScreen()),
                    );
                  },
                ),
                _buildAnimatedFloatingButton(
                  icon: Icons.calendar_today_outlined,
                  isVisible: _showOptions,
                  offset: 0.0,
                  onPressed: () {
                    _toggleOptions();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AgendarConsultaScreen()),
                    );
                  },
                ),
                _buildAnimatedFloatingButton(
                  icon: Icons.sticky_note_2_outlined,
                  isVisible: _showOptions,
                  offset: 00.0,
                  onPressed: () {
                    _toggleOptions();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelecionarPacienteScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleOptions,
        backgroundColor: const Color.fromARGB(255, 106, 186, 213),
        child: Icon(_showOptions ? Icons.close : Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: const Color.fromARGB(255, 106, 186, 213)),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            IconButton(
              icon: Icon(Icons.message_outlined, color: const Color.fromARGB(255, 106, 186, 213)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConversasScreen()),
                );
              },
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.person_outline, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PacientesScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgendaCuidador()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: const Color.fromARGB(255, 106, 186, 213)),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedFloatingButton({
    required IconData icon,
    required bool isVisible,
    required double offset,
    required VoidCallback onPressed,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0.0, isVisible ? -offset : 0.0, 0.0),
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: FloatingActionButton(
          mini: true,
          heroTag: null,
          onPressed: isVisible ? onPressed : null,
          child: Icon(icon),
        ),
      ),
    );
  }
}