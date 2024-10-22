// Mapa.dart
import 'package:flutter/material.dart';

class Mapa extends StatefulWidget {
  final Function(String) onSubmit; 
  final String currentName;

  Mapa({required this.onSubmit, required this.currentName});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void didUpdateWidget(covariant Mapa oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentName != widget.currentName) {
      _controller.text = widget.currentName;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    String name = _controller.text.trim();
    if (name.isNotEmpty) {
      widget.onSubmit(name);
      // Opcional: Limpar o campo após submissão
      // _controller.clear(); // Comentado para manter o nome no campo após submissão
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, insira um nome para a nave.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.rocket,
            color: Colors.blueAccent,
            size: 100,
          ),
          SizedBox(height: 20),
          Text(
            "Nomeie sua Nave",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            maxLength: 50,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(),
              hintText: "Digite o nome da sua nave",
              hintStyle: TextStyle(color: Colors.grey),
            ),
            // Removido o onChanged para evitar atualizações antes da submissão
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: Text("Setar nome da nave"),
          ),
        ],
      ),
    );
  }
}
