import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat_screen.dart';

class ConversasScreen extends StatelessWidget {
  const ConversasScreen({super.key});

  // Função para carregar dados do cuidador
  Future<Map<String, dynamic>> _carregarCuidador() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/api/cuidador/perfil'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Erro ao carregar cuidador: $e');
    }
    return {};
  }

  // Função para carregar dados do paciente
  Future<Map<String, dynamic>> _carregarPaciente() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/api/paciente/cadastrocompleto'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Erro ao carregar paciente: $e');
    }
    return {};
  }

  // Função para carregar dados do familiar
  Future<Map<String, dynamic>> _carregarFamiliar() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/api/familiar/perfil'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Erro ao carregar familiar: $e');
    }
    return {};
  }

  Widget _buildTab(IconData icon, String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF6ABAD5) : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF6ABAD5) : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, {
    required String name,
    required String message,
    required String imagePath,
    required int unreadCount,
    String? lastMessageTime,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatName: name,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 28,
              // Fallback para caso a imagem não carregue
              child: imagePath.isEmpty ? Icon(Icons.person) : null,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    message, 
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (lastMessageTime != null)
                  Text(
                    lastMessageTime,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                SizedBox(height: 4),
                if (unreadCount > 0)
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Text(
                      unreadCount.toString(),
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8),
            Icon(Icons.search, color: const Color.fromARGB(255, 106, 186, 213)),
            SizedBox(width: 8),
            Text('Buscar Conversas', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([
          _carregarCuidador(), 
          _carregarPaciente(), 
          _carregarFamiliar()
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Carregando conversas...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Erro ao carregar dados',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
            );
          }

          final cuidadorData = snapshot.data?[0] ?? {};
          final pacienteData = snapshot.data?[1] ?? {};
          final familiarData = snapshot.data?[2] ?? {};

          // Extrair nomes das APIs
          final cuidadorNome = cuidadorData['nome'] ?? 'Cuidador';
          final pacienteNome = pacienteData['nome'] ?? 'Paciente';
          final familiarNome = familiarData['nome'] ?? 'Familiar';

          // Formatar o nome do paciente (adicionar "Sr." ou "Sra." se necessário)
          String formatarNomePaciente(String nome) {
            if (nome == 'Paciente') return nome;
            // Verifica se já começa com Sr. ou Sra.
            if (!nome.toLowerCase().startsWith('sr.') && !nome.toLowerCase().startsWith('sra.')) {
              // Aqui você pode adicionar lógica para determinar gênero se tiver essa informação
              return 'Sr. $nome';
            }
            return nome;
          }

          final pacienteNomeFormatado = formatarNomePaciente(pacienteNome);

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTab(Icons.message_outlined, 'conversas', true),
                      _buildTab(Icons.call_outlined, 'chamadas', false),
                      _buildTab(Icons.person_outline, 'contatos', false),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                
                // Conversa com o Familiar
                _buildChatTile(
                  context,
                  name: '$familiarNome (Familiar do $pacienteNomeFormatado)',
                  message: 'Ele está bem hoje??',
                  imagePath: 'assets/pessoa1.jpg',
                  unreadCount: 4,
                  lastMessageTime: '10:30',
                ),
                
                // Conversa com o Paciente
                _buildChatTile(
                  context,
                  name: pacienteNomeFormatado,
                  message: 'Eu estou bem',
                  imagePath: 'assets/Paulosikera.jpg',
                  unreadCount: 0,
                  lastMessageTime: '09:15',
                ),

                // Conversa com o Cuidador (opcional)
                _buildChatTile(
                  context,
                  name: cuidadorNome,
                  message: 'Cuidador principal',
                  imagePath: 'assets/cuidador.jpg',
                  unreadCount: 1,
                  lastMessageTime: 'Ontem',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}