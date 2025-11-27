import 'package:flutter/material.dart';
import 'home_cuidador_screen.dart';
import 'conversas_screen.dart';
import 'pacientes_screen.dart';

class ConfirmacaoCancelamentoScreen extends StatelessWidget {
  const ConfirmacaoCancelamentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com gradiente de cor
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB3E5FC),
                  Color(0xFF81D4FA),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ícone de confirmação estilizado
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 60,
                      color: Color(0xFF63B3ED),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Você cancelou a consulta com sucesso!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Você receberá uma notificação ao chegar próximo da data.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade50,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeCuidadorScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Voltar à Tela Inicial',
                      style: TextStyle(fontSize: 16, color:Color(0xFF6ABAD5)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF6ABAD5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home, color: Color(0xFF6ABAD5)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeCuidadorScreen()),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined, color: Colors.grey),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ConversasScreen()));
            },
          ),
          const SizedBox(width: 48),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.grey),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PacientesScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
            onPressed: () {
              // Navegação para a tela de agendamento de medicamento
            },
          ),
        ],
      ),
    );
  }
}