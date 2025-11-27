import 'package:flutter/material.dart';

class SentimentosPaciente extends StatefulWidget {
  const SentimentosPaciente({super.key});

  @override
  State<SentimentosPaciente> createState() => _SentimentosPacienteState();
}

class _SentimentosPacienteState extends State<SentimentosPaciente> {
  String? _selectedEmotion;

  Widget _buildCard({
    required String label,
    required String emoji,
    required String? selectedValue,
    required ValueChanged<String> onSelect,
  }) {
    final isSelected = selectedValue == label;
    return InkWell(
      onTap: () => onSelect(label),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ?const Color.fromARGB(255, 106, 186, 213) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ?const Color.fromARGB(255, 106, 186, 213): Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
        
            },
            child: Text(
              'Enviar',
              style: TextStyle(
                color:const Color.fromARGB(255, 106, 186, 213),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Quais sentimentos\nvocê está sentindo?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color:Color.fromARGB(255, 106, 186, 213),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [
                  _buildCard(
                    label: 'Raiva',
                    emoji: '😡',
                    selectedValue: _selectedEmotion,
                    onSelect: (value) {
                      setState(() {
                        _selectedEmotion = value == _selectedEmotion ? null : value;
                      });
                    },
                  ),
                  _buildCard(
                    label: 'Alegria',
                    emoji: '😁',
                    selectedValue: _selectedEmotion,
                    onSelect: (value) {
                      setState(() {
                        _selectedEmotion = value == _selectedEmotion ? null : value;
                      });
                    },
                  ),
                  _buildCard(
                    label: 'Medo',
                    emoji: '😨',
                    selectedValue: _selectedEmotion,
                    onSelect: (value) {
                      setState(() {
                        _selectedEmotion = value == _selectedEmotion ? null : value;
                      });
                    },
                  ),
                  _buildCard(
                    label: 'Tristeza',
                    emoji: '😔',
                    selectedValue: _selectedEmotion,
                    onSelect: (value) {
                      setState(() {
                        _selectedEmotion = value == _selectedEmotion ? null : value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}