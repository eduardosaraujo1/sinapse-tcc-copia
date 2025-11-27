import 'package:flutter/material.dart';

class SymptomsScreen extends StatelessWidget {
  const SymptomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Sintomas'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de busca
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color:  const Color.fromARGB(255, 106, 186, 213),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color.fromARGB(255, 106, 186, 213)),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Color.fromARGB(255, 106, 186, 213)),
                  hintText: 'Buscar',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Seção de Sentimentos
            _buildSectionTitle('Sentimentos registrados'),
            _buildSymptomCard(
              icon: Icons.sentiment_very_dissatisfied,
              iconColor: Colors.red.shade400,
              cardColor: Colors.red.shade100,
              title: 'Sofia Cardoso',
              subtitle: 'Registrou o sentimento irritado as 19h\n16/07/25',
            ),
            _buildSymptomCard(
              icon: Icons.sentiment_very_satisfied,
              iconColor: Colors.yellow.shade800,
              cardColor: Colors.yellow.shade100,
              title: 'Sofia Cardoso',
              subtitle: 'Registrou o sentimento feliz as 19h\n16/07/2025',
            ),
            const SizedBox(height: 20),

            // Seção de Sintomas
            _buildSectionTitle('Sintomas registrados'),
            _buildSymptomCard(
              icon: Icons.sick, // Ícone de dor de cabeça corrigido
              iconColor: Colors.red.shade400,
              cardColor: Colors.red.shade100,
              title: 'Sofia Cardoso',
              subtitle: 'Registrou dor de cabeça as 15hrs\n14/05/25',
            ),
            _buildSymptomCard(
              icon: Icons.thermostat,
              iconColor: Colors.yellow.shade800,
              cardColor: Colors.yellow.shade100,
              title: 'Sofia Cardoso',
              subtitle: 'Registrou febre as 17h30\n13/04/25',
            ),
          ],
        ),
      ),
    );
  }

  // Métodos de ajuda definidos corretamente como membros da classe
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSymptomCard({
    required IconData icon,
    required Color iconColor,
    required Color cardColor,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: cardColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
