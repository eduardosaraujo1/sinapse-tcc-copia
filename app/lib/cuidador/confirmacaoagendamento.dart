import 'package:flutter/material.dart';

import 'pacientes_screen.dart'; // Importa a tela de pacientes para navegação

import 'conversas_screen.dart'; // Importa a tela de conversas para navegação
import 'agendar_consultas_screen.dart'; // Importa a tela de agendar consultas para navegação

class ConfirmarAgendamentoMedicamentoScreen extends StatefulWidget {
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

  @override
  _ConfirmarAgendamentoMedicamentoScreenState createState() =>
      _ConfirmarAgendamentoMedicamentoScreenState();
}

class _ConfirmarAgendamentoMedicamentoScreenState
    extends State<ConfirmarAgendamentoMedicamentoScreen> {
  // Converte o mês de número para nome
  String _getMonthName(int month) {
    const months = [
      "janeiro",
      "fevereiro",
      "março",
      "abril",
      "maio",
      "junho",
      "julho",
      "agosto",
      "setembro",
      "outubro",
      "novembro",
      "dezembro"
    ];
    return months[month - 1];
  }

  // Converte o dia da semana de número para nome
  String _getDayName(int day) {
    const days = [
      "segunda-feira",
      "terça-feira",
      "quarta-feira",
      "quinta-feira",
      "sexta-feira",
      "sábado",
      "domingo"
    ];
    // O weekday do Dart começa em 1 para segunda-feira, ajustamos para a lista
    return days[day - 1];
  }

  @override
  Widget build(BuildContext context) {
    // Formata a data para o texto de confirmação
    final formattedDate =
        "${_getDayName(widget.date.weekday)}, ${widget.date.day} de ${_getMonthName(widget.date.month)}";

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
          style: TextStyle(color: const Color.fromARGB(255, 106, 186, 213), fontSize: 18),
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
            children: <Widget>[
              Text(
                'Você cadastrou um medicamento para',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              Text(
                '${widget.patientName}:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$formattedDate, às ${widget.time}\n',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: 'Alterar data ou horário',
                      style: TextStyle(
                        fontSize: 14,
                        color:const Color(0xFF6ABAD5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48),
              // Campo para o nome do medicamento
              _buildTextField('Nome Do Medicamento', widget.medicationName),
              SizedBox(height: 24),
              // Campo para a dosagem
              _buildTextField('Dosagem', widget.dosage),
              SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  // Ação para confirmar o agendamento
                  // TODO: Implementar a lógica para salvar os dados
                  // e navegar para a tela de sucesso ou agenda principal
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromARGB(255, 106, 186, 213),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Confirmar agendamento',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.white,
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
              icon: Icon(Icons.message_outlined, color:const Color.fromARGB(255, 106, 186, 213)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ConversasScreen()));
              },
            ),
            SizedBox(width: 48), // Espaço para o FloatingActionButton
            IconButton(
              icon: Icon(Icons.person_outline, color: Colors.grey),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PacientesScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AgendarConsultaScreen()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Ação do botão +
        },
        backgroundColor:const Color(0xFF6ABAD5),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Constrói o campo de texto estilizado
  Widget _buildTextField(String label, String value) {
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
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}