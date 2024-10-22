// Perfil.dart
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  final Function(List<String>) onCrewSelected;

  Perfil({required this.onCrewSelected});

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  List<String> crewMembers = [
    "Orion Vega",
    "Luna Starfire",
    "Zara Nova",
    "Talon Rex",
    "Sirius Blade",
    "Phoenix Blaze",
    "Cassiopeia Ray",
    "Nova Sky",
    "Rigel Light",
    "Andromeda Jet"
  ];
  List<String> selectedCrew = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selecione sua Tripulação",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: crewMembers.map((member) {
                return CheckboxListTile(
                  activeColor: Colors.blueAccent,
                  title: Text(member, style: TextStyle(color: Colors.white)),
                  value: selectedCrew.contains(member),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        if (selectedCrew.length < 5) {
                          selectedCrew.add(member);
                        }
                      } else {
                        selectedCrew.remove(member);
                      }
                      widget.onCrewSelected(selectedCrew);
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
