import 'package:flutter/material.dart';

class DetalhesAgenda extends StatelessWidget {
  const DetalhesAgenda ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // Lógica para compartilhar o link
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Data e Hora
              _buildDetailItem(Icons.calendar_today_outlined, '22 de Dezembro'),
              _buildDetailItem(Icons.access_time, '9h00'),
              _buildDetailItem(Icons.check_circle_outline, 'Confirmada'),
              _buildDetailItem(Icons.location_on_outlined, 'Endereço', isLocation: true),
              const SizedBox(height: 24),
              // Notas da consulta
              Card(
                color: const Color.fromARGB(255, 106, 186, 213),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color:  const Color.fromARGB(255, 106, 186, 213), width: 2),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '"Preciso melhorar minha alimentação e gostaria de entrar numa dieta"',
                    style: TextStyle(
                      fontSize: 16,
                      color:  Color.fromARGB(255, 121, 116, 116),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Endereço detalhado
              const Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Praia Grande, Av. Presidente Kennedy 23154',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para os itens de detalhe
  Widget _buildDetailItem(IconData icon, String text, {bool isLocation = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isLocation) const Text('—'),
        ],
      ),
    );
  }
}