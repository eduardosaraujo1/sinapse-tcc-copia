import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.calendar_today, '22 de Dezembro'),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.access_time, '9h00'),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.check_circle_outline, 'Confirmada'),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.location_on, 'Endereço', isAddress: true),
            const SizedBox(height: 32),
            const Text(
              'Motivo da consulta',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                '“Preciso melhorar minha alimentação e gostaria de entrar numa dieta”',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Praia Grande, Av.Presidente Kennedy 23154',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, {bool isAddress = false}) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isAddress ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}