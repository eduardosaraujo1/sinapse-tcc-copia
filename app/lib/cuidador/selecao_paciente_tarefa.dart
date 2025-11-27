import 'package:flutter/material.dart';
import 'confirmar_agendamento_medicamento_screen.dart';
import 'pacientes_screen.dart';
import 'conversas_screen.dart';
import 'agendar_consultas_screen.dart';



class SelecionarPacienteTarefa extends StatelessWidget {
  const SelecionarPacienteTarefa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Próximo',
          style: TextStyle(color: const Color.fromARGB(255, 106, 186, 213), fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 24),
              Text(
                'Pra qual paciente e\nesse medicamento?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 16),
              // Campo de busca
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar pacientes',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Lista de pacientes
              _buildPatientCard(context, 'Paulo Sikera', '56 anos'),
    
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
              icon: Icon(Icons.home, color: Colors.blue),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            IconButton(
              icon: Icon(Icons.message_outlined, color: Colors.blue),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConversasScreen()));
              },
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.person_outline, color: Colors.grey),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PacientesScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AgendarConsultaScreen()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue.shade500,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildPatientCard(BuildContext context, String name, String age) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      color: Colors.lightBlue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              // TODO: Adicionar imagem do paciente
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(age),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navega para a próxima tela, passando o nome do paciente
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmarAgendamentoMedicamentoScreen(
                      patientName: name,
                      medicationName: 'Clonazepam', // Dados mockados para o fluxo
                      dosage: '1 Mg',
                      date: DateTime.now(),
                      time: '8:00',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Selecionar'),
            ),
          ],
        ),
      ),
    );
  }
}