import 'package:flutter/material.dart';
import 'register_step2_screen.dart'; // Importe a próxima tela
import 'login_screen.dart';

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({super.key});

  @override
  _RegisterStep1ScreenState createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;

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
            Navigator.push( context,
                  MaterialPageRoute(builder: (context) => LoginUnificadoScreen()),
            );
          },
        ),
        title: const Text(
          'Cadastro',
          style: TextStyle(
            color: Color(0xFF6ABAD5),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              // Use a imagem real do ícone
              Image.asset('assets/image-removebg-preview.png', height: 100),
              const SizedBox(height: 20),
              const Text(
                'Bem-Vindo!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Digite os seus dados de acesso corretamente nos campos abaixo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              // Campo de Email ou Telefone
              _buildTextFormField(
                hintText: 'julia@email',
                labelText: 'Email ou Telefone',
              ),
              const SizedBox(height: 20),
              // Campo de Senha
              _buildTextFormField(
                labelText: 'Senha',
                obscureText: !_showPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Campo de Confirmar Senha
              _buildTextFormField(
                labelText: 'Confirmar Senha',
                obscureText: !_showConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _showConfirmPassword = !_showConfirmPassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              // Botão Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para navegação
                    // Navega para a próxima tela do fluxo de cadastro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterStep2Screen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 215, 246),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Login',
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

  Widget _buildTextFormField({
    required String labelText,
    String? hintText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.lightBlue.withOpacity(0.1),
        suffixIcon: suffixIcon,
      ),
    );
  }
}