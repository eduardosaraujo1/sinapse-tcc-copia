import 'package:flutter/material.dart';
import 'password_changed_screen.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool obscure1 = true;
  bool obscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Criar Senha", style: TextStyle(color:Color.fromARGB(255, 106, 186, 213))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              obscureText: obscure1,
              decoration: InputDecoration(
                labelText: "Nova Senha",
                filled: true,
                fillColor: const Color.fromARGB(255, 106, 186, 213),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: Icon(obscure1 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => obscure1 = !obscure1),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: obscure2,
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                filled: true,
                fillColor:const Color.fromARGB(255, 106, 186, 213),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: Icon(obscure2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => obscure2 = !obscure2),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PasswordChangedScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 106, 186, 213),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Criar Nova Senha", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
