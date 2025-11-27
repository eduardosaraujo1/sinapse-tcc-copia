import 'home_cuidador_screen.dart';
import 'package:flutter/material.dart';

class TaskNotificationScreen extends StatelessWidget {
  const TaskNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ícone de sucesso estilizado e centralizado
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 106, 186, 213),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: const Icon(Icons.check_rounded, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  // Título principal
                  const Text(
                    'Você agendou uma tarefa com sucesso!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Mensagem de suporte
                  Text(
                    'Você receberá uma notificação ao chegar próximo da data.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color:const Color.fromARGB(255, 106, 186, 213),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Cartão com os detalhes da tarefa, com visual clean
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tarefa: Caminhar de manhã',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 106, 186, 213),
                            ),
                          ),
                          Text(
                            'Motivo: Paulo precisa se exercitar mais.',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          const SizedBox(height: 16),
                          Divider(color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: const Color.fromARGB(255, 106, 186, 213)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Data da tarefa cadastrada',
                                      style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                    ),
                                    const Text(
                                      'Terça-feira, 14 de dezembro, às 9:00',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 106, 186, 213),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Botão de ação principal
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
                      'Voltar a Tela Inicial',
                      style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 106, 186, 213),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}