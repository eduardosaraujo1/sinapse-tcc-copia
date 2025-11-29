import 'package:algumacoisa/cuidador/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:algumacoisa/cuidador/register_step3_screen.dart';


class RegisterStep2Screen extends StatefulWidget {
  const RegisterStep2Screen({super.key});

  @override
  _RegisterStep2ScreenState createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  String? _selectedUserType = 'familiar'; // Deixando 'familiar' pré-selecionado como na imagem

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco como na imagem
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUnificadoScreen()),
    );
              },
       
        ),
        title: const Text(
          'Cadastrar-Se',
          style: TextStyle(
            color:Color(0xFF6ABAD5),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            // Ícone e texto 'Cadastrar-Se'
            Image.asset('assets/image-removebg-preview.png', height: 100), // Use seu próprio asset de imagem
            const SizedBox(height: 20),
            const Text(
              'Deseja cadastrar se como:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Opções de tipo de usuário
            _buildUserTypeOption('Cuidador', 'cuidador'),
         
            const Spacer(),
            // Botão "Próximo"
            ElevatedButton(
              onPressed: () {
                // Lógica de navegação baseada no tipo de usuário selecionado
                if (_selectedUserType == 'cuidador') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterStep3Screen()));
                  
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:     const Color.fromARGB(255, 106, 186, 213),
           
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTypeOption(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedUserType = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _selectedUserType == value ?const Color(0xFF6ABAD5).withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _selectedUserType == value ?const Color(0xFF6ABAD5) : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              Radio<String>(
                value: value,
                groupValue: _selectedUserType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUserType = newValue;
                  });
                },
                activeColor:const Color(0xFF6ABAD5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}