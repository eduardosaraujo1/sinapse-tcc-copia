import 'package:flutter/material.dart';
import 'package:algumacoisa/familiar/home_familiar.dart'; // Importa a tela corrigida

class RegisterStep3Screen extends StatefulWidget {
  const RegisterStep3Screen({super.key});

  @override
  _RegisterStep3ScreenState createState() => _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends State<RegisterStep3Screen> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome Completo',
                hintText: 'digite seu nome',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'digite seu email',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      labelText: 'Data de Nascimento',
                    ),
                    items: List.generate(31, (index) => index + 1)
                        .map((day) => DropdownMenuItem(
                              value: day,
                              child: Text(day.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Janeiro',
                    ),
                    items: ['Janeiro', 'Fevereiro', 'Março']
                        .map((month) => DropdownMenuItem(
                              value: month,
                              child: Text(month),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      labelText: '2023',
                    ),
                    items: [2023, 2022, 2021]
                        .map((year) => DropdownMenuItem(
                              value: year,
                              child: Text(year.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text('Gênero', style: TextStyle(fontSize: 16)),
                Radio<String>(
                  value: 'F',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                Text('F'),
                Radio<String>(
                  value: 'M',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                Text('M'),
                Radio<String>(
                  value: 'O',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                Text('O'),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                hintText: 'digite seu telefone',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Endereço',
                hintText: 'digite seu endereço',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirme sua Senha',
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeFamiliar()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}