import 'package:flutter/material.dart';
import 'video_chamada_screen.dart';

class Chamadapaciente extends StatelessWidget {
  const Chamadapaciente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Nome e status da chamada
              Column(
                children: [
                  Text(
                    'Bruno',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Chamando...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              // Botões de controle de áudio
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildControlButton(Icons.mic_off, 'mutar', () {}),
                      _buildControlButton(Icons.dialpad, 'keypad', () {}),
                      _buildControlButton(Icons.volume_up, 'viva voz', () {}),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  _buildControlButton(Icons.videocam, 'faceTime', () {
                    // Navega para a tela de videochamada
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoChamadaPaciente(),
                      ),
                    );
                  }),
                ],
              ),
              // Botão de encerrar chamada
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.red,
                child: Icon(Icons.call_end, color: Colors.white, size: 36.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40.0),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32.0,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ],
    );
  }
}
