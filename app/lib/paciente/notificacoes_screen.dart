import 'package:algumacoisa/paciente/home_paciente.dart';
import 'package:flutter/material.dart';


// A classe foi renomeada para a grafia correta: NotificacoesFamiliar.
class Notificacoes extends StatelessWidget {
  const Notificacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePaciente()),
  );
},
          
        ),
      ),
      body: Container(
        // O Container com o gradiente foi mantido para o fundo.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
            ],
          ),
        ),
        // O SingleChildScrollView garante que o conteúdo seja rolável se a tela for pequena.
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Chamadas para o método auxiliar para construir os cartões de notificação.
              _buildNotificationCard(
                context,
                '27 FEB',
                'Consulta medica Cardiologista',
                'R.Malmequer 534, Jardim Real',
                'Faltam 3 dias!',
              ),
              const SizedBox(height: 16),
              _buildNotificationCard(
                context,
                '28 FEB',
                'Medicação programada',
                '2 capsulas',
                'NOVO',
              ),
              const SizedBox(height: 16),
              _buildNotificationCard(
                context,
                '01 MAR',
                'Medicação programada',
                '1 capsula',
                'NOVO',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // O método auxiliar para construir o cartão de notificação.
  // Ele foi movido para dentro da classe para ser acessível.
  Widget _buildNotificationCard(
      BuildContext context, String date, String title, String subtitle, String status) {
    return InkWell(
      onTap: () {
        // Ação de toque, por exemplo, navegar para uma tela de detalhes.
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsScreen()));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coluna para a data e o mês.
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFE1F5FE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date.split(' ')[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color:  Color.fromARGB(255, 106, 186, 213),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      date.split(' ')[1],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 106, 186, 213),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Conteúdo da notificação.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                    const SizedBox(height: 4),
                    if (status.toUpperCase() == 'NOVO')
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status.toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    else
                      Text(
                        status,
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert),
            ],
          ),
        ),
      ),
    );
  }
}
