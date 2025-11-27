import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InviteParentScreen extends StatefulWidget {
  const InviteParentScreen({super.key});

  @override
  _InvitePatientScreenState createState() => _InvitePatientScreenState();
}

class _InvitePatientScreenState extends State<InviteParentScreen> {
  final TextEditingController _accessCodeController = TextEditingController();

  void _generateAccessCode() {
    final String code = 'PAC${DateTime.now().millisecondsSinceEpoch % 10000}';
    setState(() {
      _accessCodeController.text = code;
    });
  }

  void _copyAccessCode() {
    Clipboard.setData(ClipboardData(text: _accessCodeController.text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código copiado para a área de transferência!')),
      );
    });
  }

  @override
  void dispose() {
    _accessCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
    
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Convidar Novo familiar',
          style: TextStyle(
            color: Color.fromARGB(255, 106, 186, 213),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFieldWithIcon(
                label: 'Nome Do Paciente',
                hint: 'Paulo sikera',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              _buildTextFieldWithIcon(
                label: 'E-Mail Paciente',
                hint: 'Paulosikera@Gmail.Com',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _buildTextFieldWithIcon(
                label: 'Nome Do Familiar',
                hint: 'Bruno',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              _buildTextFieldWithIcon(
                label: 'E-Mail Do Familiar',
                hint: 'Bruno@Gmail.Com',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _generateAccessCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 106, 186, 213),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Gerar Código De Acesso',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Código Gerado:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: const Color.fromARGB(255, 106, 186, 213)),
                      ),
                      child: Text(
                        _accessCodeController.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 106, 186, 213),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _copyAccessCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 106, 186, 213),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Copiar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color.fromARGB(255, 106, 186, 213)),
          ),
          child: TextField(
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}