import 'package:flutter/material.dart';

void main() {
  MyApp app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // drawer: NavDrawer(),
          appBar: MyAppBar(),
          body: DataBodyWidget(objects: const [
            "La Fin Du Monde - Bock - 65 ibu",
            "Sapporo Premiume - Sour Ale - 54 ibu",
            "Duvel - Pilsner - 82 ibu"
          ]),
          bottomNavigationBar: NewNavBar(
            Newicons: const [
              Icon(Icons.coffee_outlined),
              Icon(Icons.local_drink_outlined),
              Icon(Icons.flag_circle_outlined),
              
            ],
          ),
        ));
  }
}

class NewNavBar extends StatelessWidget {
  List<Icon> Newicons;
  NewNavBar({this.Newicons = const []});

  void botaoFoiTocado(int index) {
    print("Este botão foi clicado $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: botaoFoiTocado,
        items: Newicons.map(
            (icn) => BottomNavigationBarItem
            (label: " ", icon: icn)).
            toList());
  }
}

class MyAppBar extends AppBar {
  MyAppBar({
    Key? key,
  }) : super(
            key: key,
            title: const Text("Atividade da Receita 3"),
            backgroundColor: Color.fromARGB(218, 0, 0, 0),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => const [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text('Branco'),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text('Cinza'),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text('Roxo'),
                  ),
                ],
              ),
            ]);
}
class DataBodyWidget extends StatelessWidget {
  List<String> objects;

  DataBodyWidget({this.objects = const []});

  Expanded processarUmElemento(String obj) {
    return Expanded(
      child: Center(child: Text(obj)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: objects
            .map((obj) => Expanded(
                  child: Center(child: Text(obj)),
                ))
            .toList());
  }
}
