import 'package:flutter/material.dart';
import 'Mapa.dart';
import 'Perfil.dart';
import 'Saldo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define um esquema de cores personalizado para o tema de espaçonave
  final Color primaryColor = Colors.black;
  final Color accentColor = Colors.blueAccent;
  final Color backgroundColor = Color(0xFF1C1C1C); // Fundo escuro

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Missão Espacial',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.dark(
          primary: accentColor,
          secondary: accentColor, // Usando apenas azul para acentos
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        // Personalizar o tema do BottomNavigationBar
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black87,
          selectedItemColor: accentColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _currentIndex = 0;
  String shipName = '';
  List<String> selectedCrew = [];
  int supplies = 0;

  @override
  Widget build(BuildContext context) {
    // Determina qual tela exibir com base no índice atual
    Widget currentScreen;
    switch (_currentIndex) {
      case 0:
        currentScreen = Mapa(
          onSubmit: _submitShip, // Passa a função de submissão para o Mapa
          currentName: shipName,
        );
        break;
      case 1:
        currentScreen = Perfil(
          onCrewSelected: (crew) => setState(() => selectedCrew = crew),
        );
        break;
      case 2:
        currentScreen = Saldo(
          onSuppliesChanged: (amount) => setState(() => supplies = amount),
        );
        break;
      case 3:
        currentScreen = Status(
          crew: selectedCrew,
          supplies: supplies,
          shipName: shipName,
        );
        break;
      default:
        currentScreen = Center(child: Text("Tela não encontrada"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Missão Espacial"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: currentScreen,
      // Removido o FloatingActionButton
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch),
            label: "Nave",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: "Tripulação",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Suprimentos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Status",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Função para submeter a nave ao pseudo banco de dados
  void _submitShip(String name) {
    if (name.isNotEmpty) {
      setState(() {
        shipName = name; // Atualiza o nome da nave
        // Opcional: Limpar outras informações se necessário
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nave '$name' submetida com sucesso!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("O nome da nave não pode estar vazio.")),
      );
    }
  }
}

class Status extends StatelessWidget {
  final List<String> crew;
  final int supplies;
  final String shipName;

  Status({
    required this.crew,
    required this.supplies,
    required this.shipName,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Removida a seção 'Nome da Nave'
          Text(
            'Tripulação:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            crew.isNotEmpty ? crew.join(', ') : 'Nenhuma tripulação selecionada',
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          SizedBox(height: 20),
          Text(
            'Suprimentos:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            supplies > 0 ? '$supplies kg' : 'Nenhum suprimento definido',
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          SizedBox(height: 30),
          Text(
            'Nome da Nave:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          shipName.isNotEmpty
              ? Text(
                  '$shipName',
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                )
              : Text(
                  'Nenhuma nave submetida.',
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
        ],
      ),
    );
  }
}
