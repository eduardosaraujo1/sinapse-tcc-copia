import 'package:flutter/material.dart';

class PoliticaPrivacidadePaciente extends StatelessWidget {
  const PoliticaPrivacidadePaciente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Updated: 14/08/2024',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam. Fusce a scelerisque neque, sed accumsan metus. Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. Aenean arcu metus, bibendum at mauris vel, auctor a orci. Maecenas in magna malesuada eros semper ultrices. Vestibulum lobortis enim vel neque auctor, a ultrices ex placerat. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex. Morbi at enim justo, sed ultrices ex.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Ut lacinia justo ut amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra erat elit vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Quis laoreet, ex eget rutrum pharetra, lectus nisi posuere risus, vel facilisis mi tellus ac turpis.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. Ut lacinia justo ut amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra erat elit vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Quis laoreet, ex eget rutrum pharetra, lectus nisi posuere risus, vel facilisis mi tellus ac turpis.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '3. Ut lacinia justo ut amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra erat elit vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Quis laoreet, ex eget rutrum pharetra, lectus nisi posuere risus, vel facilisis mi tellus ac turpis.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '4. Ut lacinia justo ut amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra erat elit vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Quis laoreet, ex eget rutrum pharetra, lectus nisi posuere risus, vel facilisis mi tellus ac turpis.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}