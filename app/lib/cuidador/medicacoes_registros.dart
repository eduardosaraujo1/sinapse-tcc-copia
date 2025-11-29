import 'package:flutter/material.dart';
import 'sinais_clinicos_screen.dart';

class MedicacoesScreen extends StatefulWidget {
  final dynamic paciente; // Adicione este parâmetro

  const MedicacoesScreen({super.key, required this.paciente});

  @override
  _MedicacoesScreenState createState() => _MedicacoesScreenState();
}

class _MedicacoesScreenState extends State<MedicacoesScreen> {
  final List<Map<String, TextEditingController>> _medicamentos = [];

  @override
  void initState() {
    super.initState();
    _addMedicamentoField(); // Adiciona o primeiro campo de medicamento por padrão
  }

  void _addMedicamentoField() {
    setState(() {
      _medicamentos.add({
        'medicamento': TextEditingController(),
        'dosagem': TextEditingController(),
        'hora': TextEditingController(),
      });
    });
  }

  void _removeMedicamentoField(int index) {
    setState(() {
      // Dispose dos controllers antes de remover
      _medicamentos[index]['medicamento']?.dispose();
      _medicamentos[index]['dosagem']?.dispose();
      _medicamentos[index]['hora']?.dispose();
      _medicamentos.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (var med in _medicamentos) {
      med['medicamento']?.dispose();
      med['dosagem']?.dispose();
      med['hora']?.dispose();
    }
    super.dispose();
  }

  void _navegarParaSinaisClinicos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SinaisClinicosScreen(paciente: widget.paciente),
      ),
    );
  }

  void _salvarMedicacoes() {
    // Aqui você pode salvar os dados antes de navegar
    // Por enquanto, apenas navega para a próxima tela
    _navegarParaSinaisClinicos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: LinearProgressIndicator(
          value: 1.0, // Progresso para a última tela
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6ABAD5)), // Corrigido: removida vírgula extra
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _navegarParaSinaisClinicos,
            child: const Text('Pular', style: TextStyle(color: Colors.grey)),
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
                    backgroundColor: Colors.grey[300], // Fallback caso a imagem não exista
                    child: const Icon(Icons.person, size: 40, color: Colors.grey),
                    // Se quiser usar imagem, descomente a linha abaixo:
                    // backgroundImage: AssetImage('assets/Paulosikera.jpg'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.paciente.nome ?? 'Paciente', // Usando dados dinâmicos
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.paciente.idade ?? 'Idade não informada', 
                    style: const TextStyle(color: Colors.grey)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Medicações:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D3B51),
              ),
            ),
            const SizedBox(height: 10),
            ..._medicamentos.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, TextEditingController> med = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Medicamento ${index + 1}:',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_medicamentos.length > 1) // Mostra botão de remover apenas se houver mais de um campo
                          IconButton(
                            onPressed: () => _removeMedicamentoField(index),
                            icon: const Icon(Icons.remove_circle, color: Colors.red),
                            iconSize: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    _buildInputField(
                      controller: med['medicamento']!,
                      hintText: 'Nome do medicamento',
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            controller: med['dosagem']!,
                            hintText: 'Dosagem (ex: 500mg)',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildInputField(
                            controller: med['hora']!,
                            hintText: 'Hora (ex: 08:00)',
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                  ],
                ),
              );
            }), // Adicionado .toList() para evitar problemas
            const SizedBox(height: 20),
            Center(
              child: IconButton(
                onPressed: _addMedicamentoField,
                icon: const Icon(Icons.add_circle, color: Color(0xFF6ABAD5), size: 40),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _salvarMedicacoes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF62A7D2),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}