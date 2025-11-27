import 'package:flutter/material.dart';
import 'notificacao_medicamento.dart';
import 'pacientes_screen.dart';
import 'conversas_screen.dart';
import 'agendar_consultas_screen.dart';
import 'agendar_medicamento_screen.dart'; // Retorna para esta tela se o usuário quiser alterar data/horário

class ConfirmarAgendamentoMedicamentoScreen extends StatelessWidget {
  final String patientName;
  final String medicationName;
  final String dosage;
  final DateTime date;
  final String time;

  const ConfirmarAgendamentoMedicamentoScreen({
    super.key,
    required this.patientName,
    required this.medicationName,
    required this.dosage,
    required this.date,
    required this.time,
  });

  // Mapeia o dia da semana de número para nome em português
  String _getDayName(int day) {
    const dayNames = [
      'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado', 'Domingo'
    ];
    return dayNames[day - 1];
  }

  // Mapeia o mês de número para nome em português
  String _getMonthName(int month) {
    const monthNames = [
      'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = '${_getDayName(date.weekday)}, ${date.day} de ${_getMonthName(date.month)}';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color:const Color.fromARGB(255, 106, 186, 213)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Cadastro',
          style: TextStyle(color:const Color(0xFF6ABAD5), fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Você cadastrou um medicamento para\n$patientName:',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '$formattedDate, às $time',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  // Aqui você pode navegar de volta para a tela de agendamento de medicamento
                  // para permitir que o usuário altere a data/hora.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AgendarMedicamentoScreen()),
                  );
                },
                child: const Text(
                  'Alterar data ou horário',
                  style: TextStyle(
                      color: Color(0xFF6ABAD5), decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 48),
              _buildInfoField('Nome Do Medicamento', medicationName),
              const SizedBox(height: 24),
              _buildInfoField('Dosagem', dosage),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: () {
                  // Navega para a tela de confirmação de sucesso
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmacaoMedicamentos(
                        medicationName: medicationName,
                        dosage: dosage,
                        date: date,
                        time: time,
                          patientName:patientName,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color(0xFF6ABAD5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Confirmar agendamento',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, color:Color.fromARGB(255, 106, 186, 213)),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            IconButton(
              icon: const Icon(Icons.message_outlined, color: Color.fromARGB(255, 106, 186, 213),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConversasScreen()),
                );
              },
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PacientesScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgendarConsultaScreen()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF6ABAD5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6ABAD5),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}