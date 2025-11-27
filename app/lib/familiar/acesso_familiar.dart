import 'package:flutter/material.dart';
import 'package:algumacoisa/cuidador/register_step2_screen.dart';
import 'package:algumacoisa/familiar/Registraofamiliar.dart';

class AcessoFamiliar extends StatelessWidget {
  const AcessoFamiliar ({super.key});

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterStep2Screen()),
                );
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
              
              const SizedBox(height: 40),
              // Campo de Código de Acesso
              const Text(
                'Código De acesso',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'digite seu telefone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 106, 186, 213).withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 20),
              // Campo de Nome do Paciente
              const Text(
                'Nome Do Paciente',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'digite seu endereço',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 106, 186, 213).withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 20),
              // Campo de Email do Paciente
              const Text(
                'Email do Paciente',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: true, // Para esconder a senha/email
                decoration: InputDecoration(
                  hintText: '**************',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 106, 186, 213).withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 150), // Espaçamento para empurrar o botão para baixo
              // Botão Próximo
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registraofamiliar()),
                );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 106, 186, 213),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Próximo',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
}