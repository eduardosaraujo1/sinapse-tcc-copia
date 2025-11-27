import 'package:flutter/material.dart';

class ConvidarNovoPacienteScreen extends StatelessWidget {
  const ConvidarNovoPacienteScreen({super.key});

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
        title: Text('Convidar Novo Paciente'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text('Nome Do Paciente', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.lightBlue.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 15),
            Text('E-Mail Paciente', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.lightBlue.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 20),
            Text('Nome Do Familiar', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.lightBlue.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 15),
            Text('E-Mail Do Familiar', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.lightBlue.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6ABAD5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text('Gerar Código De Acesso'),
            ),
            SizedBox(height: 20),
            Text('Código Gerado:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('PAC3450-7', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: Text('Copiar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
