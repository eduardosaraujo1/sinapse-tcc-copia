import 'package:flutter/material.dart';

// Definindo a classe para representar um sentimento
class Sentimento {
  final String emoji;
  final String nome;
  final String descricao;
  final String data;
  final Color cor;

  const Sentimento({
    required this.emoji,
    required this.nome,
    required this.descricao,
    required this.data,
    required this.cor,
  });
}

class SentimentosFamiliar extends StatelessWidget {
  const SentimentosFamiliar({super.key});

  final List<Sentimento> _sentimentos = const [
    Sentimento(
      emoji: '😠',
      nome: 'Paulo sikera',
      descricao: 'Registrou o sentimento irritado às 10hrs',
      data: '16/07/2025',
      cor: Color(0xFFE7F4FE), // Cor azul clara
    ),
 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Sentimentos registrados'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            // Search field
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ),
            
            // List of feelings
            Expanded(
              child: ListView.builder(
                itemCount: _sentimentos.length,
                itemBuilder: (context, index) {
                  return _buildFeelingCard(_sentimentos[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeelingCard(Sentimento sentimento) {
    Color cardColor = sentimento.emoji == '😠'
        ? const Color(0xFFFEE7E7) // Cor rosa clara para irritado
        : const Color(0xFFE7F4FE); // Cor amarela clara para feliz

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Emoji or Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              sentimento.emoji,
              style: const TextStyle(fontSize: 40),
            ),
          ),
          const SizedBox(width: 16),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  sentimento.nome,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sentimento.descricao,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sentimento.data,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
