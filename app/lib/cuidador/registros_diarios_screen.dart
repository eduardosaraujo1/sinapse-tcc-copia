import 'package:algumacoisa/cuidador/sentimentos_paciente_screen.dart';
import '../config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrosDiariosScreen extends StatefulWidget {
  final dynamic paciente;

  const RegistrosDiariosScreen({super.key, required this.paciente});

  @override
  _RegistrosDiariosScreenState createState() => _RegistrosDiariosScreenState();
}

class _RegistrosDiariosScreenState extends State<RegistrosDiariosScreen> {
  final List<String> _selectedActivities = [];
  final TextEditingController _otherController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _otherController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  Future<void> _salvarRegistro() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> requestBody = {
        'paciente_id': widget.paciente.id,
        'atividades_realizadas': _selectedActivities.join(', '),
        'outras_atividades': _otherController.text,
        'observacoes_gerais': _observationsController.text,
      };

      final response = await http.post(
        Uri.parse('${Config.apiUrl}/api/registrosdiarios/novo'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          _navegarParaSentimentos();
        } else {
          _mostrarErro(data['message'] ?? 'Erro ao salvar registro');
        }
      } else {
        _mostrarErro('Erro na conexão: ${response.statusCode}');
      }
    } catch (e) {
      _mostrarErro('Erro: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
    );
  }

  void _navegarParaSentimentos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SentimentosPacienteScreen(
          paciente: widget.paciente,
        ), // Adicione o paciente aqui
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double progressValue = 0.2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progressValue,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _salvarRegistro,
            child: _isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('Próximo', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.paciente.nome,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.paciente.idade ?? 'Idade não informada',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildCheckboxRow(['Banho', 'Exercícios']),
            _buildCheckboxRow(['Alimentação', 'Medicação']),
            _buildCheckboxRow(['Conversas', 'Outros']),
            SizedBox(height: 20),
            Text(
              'Outros...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _otherController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Descreva...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Observações gerais',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _observationsController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Descreva o que aconteceu no dia...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _salvarRegistro,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF62A7D2),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text('Próximo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(List<String> titles) {
    return Row(
      children: titles
          .map(
            (title) => Expanded(
              child: CheckboxListTile(
                title: Text(title),
                value: _selectedActivities.contains(title),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedActivities.add(title);
                    } else {
                      _selectedActivities.remove(title);
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          )
          .toList(),
    );
  }
}
