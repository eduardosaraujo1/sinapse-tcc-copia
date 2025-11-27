import 'package:flutter/material.dart';
import 'chamada_screen.dart';
import 'video_chamada_screen.dart';

class ChatScreen extends StatelessWidget {
  final String chatName;
  final String imagePath;

  const ChatScreen({super.key, required this.chatName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 20,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chatName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Online', style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoChamadaScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.call_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChamadaScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDateSeparator('HOJE'),
                  _buildMessageBubble(
                    context,
                    text: 'Olá, tudo bem?',
                    isSentByMe: true,
                    time: '09:25 AM',
                    imagePath: 'assets/henrique_bueno.png',
                  ),
                  _buildMessageBubble(
                    context,
                    text: 'Oi, tudo sim, e vc',
                    isSentByMe: false,
                    time: '09:25 AM',
                    imagePath: 'assets/henrique_bueno.png',
                  ),
                ],
              ),
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text(
          date,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, {
    required String text,
    required bool isSentByMe,
    required String time,
    required String imagePath,
  }) {
    final alignment = isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final color = isSentByMe ? Color(0xFFE3F2FD) : Colors.grey.shade200;
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomLeft: isSentByMe ? Radius.circular(12) : Radius.circular(0),
      bottomRight: isSentByMe ? Radius.circular(0) : Radius.circular(12),
    );

    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isSentByMe)
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 16,
          ),
        SizedBox(width: 8),
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: Text(text),
        ),
        SizedBox(width: 8),
        Text(time, style: TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.attach_file, color:const Color.fromARGB(255, 106, 186, 213)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Digite sua mensagem',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 106, 186, 213),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
