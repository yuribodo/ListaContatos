import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Contact {
  final String name;
  final String phoneNumber;
  final String email;

  Contact({required this.name, required this.phoneNumber, required this.email});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [];

  void onContactAdded(Contact newContact) {
    setState(() {
      contacts.add(newContact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddContactScreen(onContactAdded: onContactAdded)),
                );
              },
              child: Text('Adicionar Contato'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewContactsScreen(contacts: contacts)),
                );
              },
              child: Text('Visualizar Contatos'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddContactScreen extends StatefulWidget {
  final Function(Contact) onContactAdded;

  AddContactScreen({required this.onContactAdded});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Criar um novo contato com os dados fornecidos pelos controladores
                Contact newContact = Contact(
                  name: nameController.text,
                  phoneNumber: phoneNumberController.text,
                  email: emailController.text,
                );

                // Chamar a função de callback para adicionar o novo contato à lista
                widget.onContactAdded(newContact);

                // Voltar para a tela inicial
                Navigator.pop(context);
              },
              child: Text('Adicionar Contato'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewContactsScreen extends StatelessWidget {
  final List<Contact> contacts;

  ViewContactsScreen({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Contatos'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text('Telefone: ${contacts[index].phoneNumber}\nEmail: ${contacts[index].email}'),
          );
        },
      ),
    );
  }
}
