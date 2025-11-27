import 'package:flutter/material.dart';

class RelatorioPacienteScreen extends StatelessWidget {
  const RelatorioPacienteScreen({super.key});

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
        title: Text('Relatório Do Paciente'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/Paulosikera.jpg'),
                radius: 40,
              ),
            ),
            SizedBox(height: 10),
            Text('Paulo Sikera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('16/10/2025', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Text(
              "O Paciente Paulo Sikera, De 65 Anos, Foi Acompanhado Ao Longo Do Dia "
              "Apresentando Bom Estado Geral, Conforme Registros, Ele Realizou "
              "Normalmente Sua Alimentação E Fez Uso Correto Da Medicação Prescrita. "
              "As Demais Atividades - Como Banhos, Exercícios, Conversas E Outros - "
              "Não Foram Marcadas Como Realizadas, E O Campo 'Outros' Não Contém "
              "Informações Adicionais. Além Disso, Nenhuma Observação Geral Foi "
              "Registrada, Não Sendo Mencionadas Alterações Comportamentais, "
              "Emocionais Ou De Níveis De Atenção Relevantes No Período.",
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text('Ler Mais', style: TextStyle(color: const Color.fromARGB(255, 106, 186, 213))),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 106, 186, 213),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Gerar PDF'),
            ),
          ],
        ),
      ),
    );
  }
}