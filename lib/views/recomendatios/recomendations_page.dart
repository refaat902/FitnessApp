import 'package:flutter/material.dart';

class RecomendationsPage extends StatelessWidget {
  const RecomendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text('Ai Meals'),
      ),
    );
  }
}
