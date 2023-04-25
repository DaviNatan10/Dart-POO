import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Formulário Tarefa 6';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _cidade= '';
  String? _gender;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Dados do Formulario"),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe Seu Nome';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe Seu Email.';
                }
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cidade',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite a Cidade onde mora. Fi do cabrunco';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            const Text("\nGênero"),
            RadioListTile(
              title: const Text('Masculino'),
              value: 'Masculino',
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value as String?;
                });
              },
            ),
            RadioListTile(
              title: const Text('Feminino'),
              value: 'Feminino',
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value as String?;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Idade',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, digite sua idade.';
                }
              },
              onSaved: (value) {
                _age = int.parse(value!);
              },
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processando dados...')),
                    );
                    
                  }
                },
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}