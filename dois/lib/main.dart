import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<dynamic> dataList = [];
  // método assíncrono para consumir informações de uma api
  Future<void> fetchData() async {
    // realiza a requisição
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    // verifica êxito da requisição
    if (response.statusCode == 200) {
      // converte resposta em objeto json
      final jsonResponse = json.decode(response.body);
      // atualiza state
      setState(() {
        dataList = jsonResponse;
      });
    } else {
      // erro na requisição
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Response Demo'),
        ),
        body: ListView.builder(
          itemCount: dataList.length, // Quantidade de itens na lista.
          itemBuilder: (BuildContext context, int index) {
            final item = dataList[index]; // Obtem o item atual da lista.

            // Retorna um container com estilo condicional baseado no ID.
            return Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: item['id'] % 2 == 0
                    ? const Color.fromARGB(255, 16, 235, 16)
                    : const Color.fromARGB(
                        255, 15, 180, 205), // Cores alternadas.
                borderRadius: BorderRadius.circular(10.0), // Borda arredondada.
              ),
              child: ListTile(
                title: Text('Name: ${item['name']}'), // Nome do usuário.
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username: ${item['username']}',
                        style: TextStyle(fontSize: 16)),
                    Text('Email: ${item['email']}',
                        style: TextStyle(fontSize: 16)),
                    Text('Phone: ${item['phone']}',
                        style: TextStyle(fontSize: 16)),
                    Text('Website: ${item['website']}',
                        style: TextStyle(fontSize: 16)),
                    const Divider(
                        color: Colors.black, thickness: 1), // Divisória visual.
                    Text('Company: ${item['company']['name']}',
                        style: TextStyle(fontSize: 16)),
                    Text('Catch Phrase: ${item['company']['catchPhrase']}',
                        style: TextStyle(fontSize: 16)),
                    Text('BS: ${item['company']['bs']}',
                        style: TextStyle(fontSize: 16)),
                    const Divider(color: Colors.black, thickness: 1),
                    Text('Street: ${item['address']['street']}',
                        style: TextStyle(fontSize: 16)),
                    Text('Suite: ${item['address']['suite']}',
                        style: TextStyle(fontSize: 16)),
                    Text('City: ${item['address']['city']}',
                        style: TextStyle(fontSize: 16)),
                    Text('Zipcode: ${item['address']['zipcode']}',
                        style: TextStyle(fontSize: 16)),
                    Text('Longitude: ${item['address']['geo']['lng']}',
                        style: TextStyle(fontSize: 12)),
                    Text('Latitude: ${item['address']['geo']['lat']}',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp()); // Inicia o aplicativo.
}
