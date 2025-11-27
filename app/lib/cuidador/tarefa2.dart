  import 'package:flutter/material.dart';
  import 'home_cuidador_screen.dart';

  class TaskNotificationScreen extends StatelessWidget {
    final String paciente;
    final String descricao;
    final String motivo;
    final DateTime data;
    final String hora;

    const TaskNotificationScreen({
      super.key,
      required this.paciente,
      required this.descricao,
      required this.motivo,
      required this.data,
      required this.hora,
    });

    String _formatarData(DateTime data) {
      final diasSemana = [
        'Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira',
        'Quinta-feira', 'Sexta-feira', 'Sábado'
      ];
      
      final meses = [
        'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
        'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
      ];
      
      final diaSemana = diasSemana[data.weekday - 1];
      final mesExtenso = meses[data.month - 1];
      
      return '$diaSemana, ${data.day} de $mesExtenso de ${data.year}';
    }

    @override
    Widget build(BuildContext context) {
      final dataFormatada = _formatarData(data);
      final corPrincipal = const Color(0xFF6ABAD5);

      return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    corPrincipal.withOpacity(0.9),
                    corPrincipal,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Icon(Icons.check_rounded, size: 60, color: corPrincipal),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Tarefa agendada com sucesso!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Você receberá uma notificação próximo da data.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 32),
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
                            Text(
                              'Tarefa: $descricao',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: corPrincipal,
                              ),
                            ),
                            Text(
                              'Motivo: $motivo',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 16),
                            Divider(color: Colors.grey.shade300),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.person, color: corPrincipal),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Paciente',
                                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                      ),
                                      Text(
                                        paciente,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: corPrincipal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: corPrincipal),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Data da tarefa',
                                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                      ),
                                      Text(
                                        '$dataFormatada, às $hora',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: corPrincipal,
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
                    ElevatedButton(
                  onPressed: () {
  print('Botão pressionado - Navegando para HomeCuidadorScreen');
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => HomeCuidadorScreen()),
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
                      child: Text(
                        'Voltar a Tela Inicial',
                        style: TextStyle(fontSize: 16, color: corPrincipal, fontWeight: FontWeight.bold),
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
