import 'package:flutter/material.dart';

class InformacoesPessoais extends StatelessWidget {
  const InformacoesPessoais({super.key});

  Widget _buildInfoCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
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
                'Informações Pessoais',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 106, 186, 213),
                ),
              ),
              const SizedBox(height: 40),
              _buildInfoCard('Idade', '35 Anos'),
              const SizedBox(height: 10),
              _buildInfoCard('Tipo Sanguíneo', 'A+'),
              const SizedBox(height: 10),
              _buildInfoCard('Problemas De Saúde', 'Diabetes, Asma, Ansiedade'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildInfoCard('Altura', '1,56m')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildInfoCard('Peso', '76kg')),
                ],
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Ação para atualizar
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 106, 186, 213),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Atualizar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
