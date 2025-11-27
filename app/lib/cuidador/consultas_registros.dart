import 'package:flutter/material.dart';
import 'medicacoes_registros.dart'; // Verifique se este é o nome correto do arquivo

class ConsultasScreen extends StatefulWidget {
  final dynamic paciente; // Adicione este parâmetro

  const ConsultasScreen({super.key, required this.paciente});

  @override
  _ConsultasScreenState createState() => _ConsultasScreenState();
}

class _ConsultasScreenState extends State<ConsultasScreen> {
  final TextEditingController _especialistaController = TextEditingController();
  final TextEditingController _descricaoConsultaController = TextEditingController();

  @override
  void dispose() {
    _especialistaController.dispose();
    _descricaoConsultaController.dispose();
    super.dispose();
  }

  void _navegarParaMedicacoes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicacoesScreen(paciente: widget.paciente), // Passe o paciente
      ),
    );
  }

  void _salvarConsulta() {
    // Aqui você pode adicionar a lógica para salvar os dados da consulta
    // Por enquanto, apenas navega para a próxima tela
    _navegarParaMedicacoes();
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
          value: 0.66, // Progresso para a segunda tela
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6ABAD5)), // Corrigido: removida vírgula extra
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _navegarParaMedicacoes,
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
                    backgroundColor: Colors.grey[300], // Fallback
                    child: const Icon(Icons.person, size: 40, color: Colors.grey),
                    // backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.paciente.nome ?? 'Paciente', // Dados dinâmicos
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.paciente.idade ?? 'Idade não informada', // Dados dinâmicos
                    style: const TextStyle(color: Colors.grey)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Consultas:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D3B51),
              ),
            ),
            const SizedBox(height: 10),
            _buildInputField(
              controller: _especialistaController,
              hintText: 'Especialista (ex: Cardiologista, Neurologista)',
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descricaoConsultaController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Descrição geral da consulta:',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Documentos da consulta:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D3B51),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Lógica para adicionar documento
                _adicionarDocumento();
              },
              icon: const Icon(Icons.add, color: Colors.blue),
              label: const Text('Adicionar documento', style: TextStyle(color: Colors.blue)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            const SizedBox(height: 10),
            // Lista de documentos adicionados (opcional)
            _buildListaDocumentos(),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _salvarConsulta,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF62A7D2),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Próximo'),
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

  void _adicionarDocumento() {
    // Simulação de adição de documento
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de adicionar documento em desenvolvimento'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildListaDocumentos() {
    // Placeholder para lista de documentos
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.grey, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Nenhum documento adicionado ainda',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}