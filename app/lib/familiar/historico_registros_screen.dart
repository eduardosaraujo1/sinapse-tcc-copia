import 'package:flutter/material.dart';

class HistoricoRegistrosScreen extends StatelessWidget {
  const HistoricoRegistrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Histórico De Registros'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Todas',
              style: TextStyle(color: const Color.fromARGB(255, 106, 186, 213)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHistoryCard(
              icon: Icons.medical_services_outlined,
              title: 'Remédio',
              date: '16/10/2025',
              content: 'Cuidador Registrou novo medicamento\nRemedio: Clonazepam\nDosagem: 2 comprimidos...',
            ),
            _buildHistoryCard(
              icon: Icons.event,
              title: 'Consulta',
              date: '15/10/2025',
              content: 'Cuidador Registrou uma nova consulta\nMedico: Cardiologista\nData: 19/10/2025...',
            ),
            _buildHistoryCard(
              icon: Icons.sick_outlined,
              title: 'Sintomas',
              date: '15/10/2025',
              content: 'Você registrou um novo sintoma\nDores de Cabeça',
            ),
            _buildHistoryCard(
              icon: Icons.event,
              title: 'Consulta',
              date: '15/10/2025',
              content: 'Cuidador Registrou uma nova consulta\nMedico: Clínico Geral\nData: 18/10/2025...',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard({required IconData icon, required String title, required String date, required String content}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: const Color.fromARGB(255, 106, 186, 213)),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        date,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(content),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Verificar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}