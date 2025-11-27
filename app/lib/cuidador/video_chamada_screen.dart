import 'package:flutter/material.dart';

class VideoChamadaScreen extends StatelessWidget {
  const VideoChamadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Fundo da chamada (pode ser um stream de vídeo real)
          Container(
            color: Colors.black,
            child: Center(
              child: Text(
                '[Stream de vídeo principal do paciente]',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bruno',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '02:35', // Tempo da chamada
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      // Janela de vídeo pequena (self-view)
                      Container(
                        width: 80.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: AssetImage('assets/carolina.png'), // Substituir pela imagem do cuidador
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // Botões de controle na parte inferior
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildBottomButton(Icons.mic_off, 'Mutar', () {}),
                        _buildBottomButton(Icons.cameraswitch, 'Virar', () {}),
                        _buildBottomButton(Icons.call_end, 'Encerrar', () {
                          Navigator.pop(context);
                        }, isEndCall: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(IconData icon, String label, VoidCallback onTap, {bool isEndCall = false}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isEndCall ? Colors.red : Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28.0,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ],
    );
  }
}
