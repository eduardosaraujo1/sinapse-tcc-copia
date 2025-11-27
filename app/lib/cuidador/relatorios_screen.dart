import 'package:flutter/material.dart';
import 'relatorio_paciente_screen.dart';

class RelatoriosScreen extends StatelessWidget {
  const RelatoriosScreen({super.key});

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
        title: Text('Relatórios'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildRelatorioCard(
              context,
              'Cuidador Registrou novo medicamento',
              'Remedio: Dipirona\nDosagem: 2 comprimidos...',
              '16/10/2025',
            ),
        
          ],
        ),
      ),
    );
  }

  Widget _buildRelatorioCard(BuildContext context, String title, String subtitle, String date) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  if (subtitle.isNotEmpty) Text(subtitle, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Text(date, style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RelatorioPacienteScreen()),
                );
              },
              child: Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}