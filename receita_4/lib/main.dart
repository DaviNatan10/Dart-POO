import 'package:flutter/material.dart';

var dataObjects = [  
    {      "name": "Heineken",      "style": "Lager",      "ibu": "25"    },  
    {      "name": "Guinness",      "style": "Stout",      "ibu": "45"    },   
    {      "name": "Corona Extra",       "style": "Pale Lager",       "ibu": "18"    },  
    {      "name": "Budweiser",      "style": "American Lager",      "ibu": "12"    }, 
    {      "name": "Chimay Blue",      "style": "Belgian Strong Dark Ale",      "ibu": "30"    },  
    {      "name": "Samuel Adams Boston Lager",       "style": "Vienna Lager",       "ibu": "30"    },  
    {      "name": "Sierra Nevada Pale Ale",      "style": "American Pale Ale",      "ibu": "37"    }, 
    {      "name": "Hoegaarden Witbier",      "style": "Witbier",      "ibu": "15"    },  
    {      "name": "Weihenstephaner Hefeweissbier",       "style": "Hefeweizen",       "ibu": "14"    },  
    {      "name": "Pilsner Urquell",      "style": "Pilsner",      "ibu": "40"    },   
    {      "name": "Leffe Blonde",      "style": "Belgian Blond Ale",      "ibu": "20"    },   
    {      "name": "Duvel",       "style": "Belgian Strong Ale",       "ibu": "32"    }, 
    {      "name": "Stone IPA",      "style": "American IPA",      "ibu": "77"    },   
    {      "name": "Paulaner Oktoberfest Bier",      "style": "Märzen",      "ibu": "22"    }, 
    {      "name": "Chimay Red",       "style": "Dubbel",      "ibu": "20"    }, 
    {      "name": "Heineken",      "style": "Lager",      "ibu": "25"    },  
    {      "name": "Guinness",      "style": "Stout",      "ibu": "45"    },   
    {      "name": "Corona Extra",       "style": "Pale Lager",       "ibu": "18"    },  
    {      "name": "Budweiser",      "style": "American Lager",      "ibu": "12"    }, 
    {      "name": "Chimay Blue",      "style": "Belgian Strong Dark Ale",      "ibu": "30"    },  
    {      "name": "Samuel Adams Boston Lager",       "style": "Vienna Lager",       "ibu": "30"    },  
    {      "name": "Sierra Nevada Pale Ale",      "style": "American Pale Ale",      "ibu": "37"    }, 
    {      "name": "Hoegaarden Witbier",      "style": "Witbier",      "ibu": "15"    },  
    {      "name": "Weihenstephaner Hefeweissbier",       "style": "Hefeweizen",       "ibu": "14"    },  
    {      "name": "Pilsner Urquell",      "style": "Pilsner",      "ibu": "40"    },   
    {      "name": "Leffe Blonde",      "style": "Belgian Blond Ale",      "ibu": "20"    },   
    {      "name": "Duvel",       "style": "Belgian Strong Ale",       "ibu": "32"    }, 
    {      "name": "Stone IPA",      "style": "American IPA",      "ibu": "77"    },   
    {      "name": "Paulaner Oktoberfest Bier",      "style": "Märzen",      "ibu": "22"    }, 
    {      "name": "Chimay Red",       "style": "Dubbel",      "ibu": "20"    }, 
     ];





void main() {

  MyApp app = MyApp();

  runApp(app);

}





class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        appBar: AppBar( 
          title: const Text("Dicas"),
        ),
        body: SingleChildScrollView(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataBodyWidget(
                      objects: dataObjects,
                      columnNames: ["Nome", "Estilo", "IBU"],
                      propertyNames: ["name", "style", "ibu"]
                    )
                  )
                ),
          bottomNavigationBar: NewNavBar(),
        ));
  }
}





class NewNavBar extends StatelessWidget {

  NewNavBar();



  void botaoFoiTocado(int index) {

    print("Tocaram no botão $index");

  }



  @override

  Widget build(BuildContext context) {

    return BottomNavigationBar(onTap: botaoFoiTocado, items: const [

      BottomNavigationBarItem(

        label: "Cafés",

        icon: Icon(Icons.coffee_outlined),

      ),

      BottomNavigationBarItem(

          label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),

      BottomNavigationBarItem(label: "Nações", icon: Icon(Icons.flag_outlined))

    ]);

  }

}



class DataBodyWidget extends StatelessWidget {
  final List<Map<String, dynamic>> objects;
  final List<String> columnNames;
  final List<String> propertyNames;
  DataBodyWidget(
      {this.objects = const [],
      this.columnNames = const [],
      this.propertyNames = const []});
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: objects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList()))
            .toList());
  }
}

class MyTileWidget extends StatelessWidget {
  List<Map<String, dynamic>> objects;
  final List<String> columnNames;
  final List<String> propertyNames;

  MyTileWidget(
      {this.objects = const [],
      this.columnNames = const [],
      this.propertyNames = const []});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: objects.length,
      itemBuilder: (context, index) {
        final obj = objects[index];

        final columnTexts = columnNames.map((col) {
          final prop = propertyNames[columnNames.indexOf(col)];
          return Text("$col: ${obj[prop]}");
        }).toList();

        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnTexts,
          ),
        );
      },
    );
  }
}