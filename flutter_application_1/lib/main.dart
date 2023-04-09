import 'package:flutter/material.dart';
void main() {
  MaterialApp app = MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.red,
      textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color.fromARGB(255, 3, 3, 3))),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          "Top 3 Clubes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "1° Barcelona",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),
            ),
            Text(
              "2° Real Madrid",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),
            ),
            Text(
              "3° Manchester City",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 18),
            Image.network(
              'https://logosmarcas.net/wp-content/uploads/2020/04/Barcelona-Logo.png',
                height: 150,
                width: 150,

              
            ),
            Image.network(
              'https://logodetimes.com/wp-content/uploads/real-madrid.png',
                height: 100,
                width: 100,

              
            ),
            Image.network(
              'https://assets.b9.com.br/wp-content/uploads/2015/12/mcfc-new-crest0.png',
                height: 100,
                width: 100,

              
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // define o item selecionado
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.switch_account_rounded),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
    ),
  );
  runApp(app);
}