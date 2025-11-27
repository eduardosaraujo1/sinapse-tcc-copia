import 'package:flutter/material.dart';

class ConfirmacaoConsulta extends StatelessWidget {
  final String paciente;
  final String data;
  final String hora;
  final String especialidade;
  final String medicoNome;

  const ConfirmacaoConsulta({
    super.key,
    required this.paciente,
    required this.data,
    required this.hora,
    required this.especialidade,
    required this.medicoNome,
  });

  // Método para formatar a data em um formato mais amigável
  String _formatarData(String data) {
    try {
      // Se a data estiver no formato "dd/MM/yyyy"
      if (data.contains('/')) {
        final parts = data.split('/');
        if (parts.length == 3) {
          final dia = int.parse(parts[0]);
          final mes = int.parse(parts[1]);
          final ano = int.parse(parts[2]);
          
          final meses = [
            'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
            'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
          ];
          
          final diasSemana = [
            'Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira',
            'Quinta-feira', 'Sexta-feira', 'Sábado'
          ];
          
          final dateTime = DateTime(ano, mes, dia);
          final diaSemana = diasSemana[dateTime.weekday - 1];
          final mesExtenso = meses[mes - 1];
          
          return '$diaSemana, $dia de $mesExtenso de $ano, às $hora';
        }
      }
      
      // Se não conseguir formatar, retorna o formato original
      return '$data, às $hora';
    } catch (e) {
      // Em caso de erro, retorna o formato original
      return '$data, às $hora';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFormatada = _formatarData(data);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Cadastro",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6ABAD5),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Você cadastrou uma consulta para",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      paciente,
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6ABAD5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    
                    // Informações da consulta
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6ABAD5).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF6ABAD5).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Data e hora
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: const Color(0xFF6ABAD5),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  dataFormatada,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          
                          // Especialidade
                          Row(
                            children: [
                              Icon(
                                Icons.medical_services,
                                color: const Color(0xFF6ABAD5),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Especialidade: $especialidade',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          
                          // Médico
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: const Color(0xFF6ABAD5),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Médico: $medicoNome',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Navega de volta para alterar data/horário
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Alterar data ou horário",
                        style: TextStyle(
                          color: Color(0xFF6ABAD5),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Motivo da consulta",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6ABAD5),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:
                      "O que você está sentindo ou precisa? Por exemplo:\n\"Estou muito ansioso e com dificuldade para dormir\"",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  filled: true,
                  fillColor: const Color(0xFF6ABAD5).withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para confirmar o agendamento
                    _confirmarAgendamento(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6ABAD5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 2,
                  ),
                  child: const Text(
                    "Confirmar agendamento",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmarAgendamento(BuildContext context) {
    // Mostrar diálogo de confirmação
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirmação",
            style: TextStyle(
              color: Color(0xFF6ABAD5),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Consulta agendada para:"),
              const SizedBox(height: 8),
              Text(
                paciente,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Data: $hora, $data"),
              Text("Especialidade: $especialidade"),
              Text("Médico: $medicoNome"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                // Fecha o diálogo e navega para a tela de confirmação final
                Navigator.of(context).pop();
                _navegarParaConfirmacaoFinal(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6ABAD5),
              ),
              child: const Text(
                "Confirmar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navegarParaConfirmacaoFinal(BuildContext context) {
    // Aqui você pode navegar para a tela de notificação de confirmação
    // ou mostrar um SnackBar de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Consulta agendada com sucesso para $paciente!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
    
    // Opcional: Navegar para a tela inicial ou outra tela
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => TelaInicial()),
    //   (route) => false,
    // );
  }
}