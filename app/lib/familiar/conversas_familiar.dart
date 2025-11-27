import 'package:flutter/material.dart';
import 'chat_familiar.dart';

class ConversasFamiliar extends StatelessWidget {
  const ConversasFamiliar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8),
            Icon(Icons.search, color: const Color.fromARGB(255, 106, 186, 213)),
            SizedBox(width: 8),
            Text('Buscar Conversas', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab(Icons.message_outlined, 'conversas', true),
                  _buildTab(Icons.call_outlined, 'chamadas', false),
                  _buildTab(Icons.person_outline, 'contatos', false),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildChatTile(
              context,
              name: 'Paulo Sikera',
              message: 'Estou bem hoje filho',
              imagePath: 'assets/Paulosikera.jpg',
              unreadCount: 4,
            ),
            _buildChatTile(
              context,
              name: 'Cuidador',
              message: 'levei seu pai para passear',
              imagePath: 'assets/carolina.png',
              unreadCount: 4,
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? const Color.fromARGB(255, 106, 186, 213) : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color.fromARGB(255, 106, 186, 213) : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, {
    required String name,
    required String message,
    required String imagePath,
    required int unreadCount,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatName: name,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 28,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(message, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            if (unreadCount > 0)
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red,
                child: Text(
                  unreadCount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
