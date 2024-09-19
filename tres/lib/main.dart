import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//inicia aplicação
void main() {
  runApp(MyApp()); //cria e executa instância
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => TelaA(),
        '/telaB': (context) => TelaB(),
        '/telaC': (context) => TelaC(),
        '/telaD': (context) => TelaD()
      },
    );
  }
}

class TelaA extends StatefulWidget {
  @override
  StateA createState() => StateA();
}

class StateA extends State<TelaA> {
  // botão de envio
  void _enviar() {
    // define resposta
    setState(() {
      Navigator.pushReplacementNamed(context, '/telaB');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela A')),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network(
              'https://files.cercomp.ufg.br/weby/up/1/o/Logo_Escola_do_Futuro_jan23.png?1674135062',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 50),
            SizedBox(
                // label para primeiro número
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _enviar,
                      child: const Text('Enviar'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class TelaB extends StatefulWidget {
  @override
  StateB createState() => StateB();
}

class StateB extends State<TelaB> {

  final TextEditingController _nome = TextEditingController();
  final TextEditingController _email = TextEditingController();
  // define cores para mensagens de aviso
  Color textColor = Colors.black; // default color
  Color textColorWarning = Colors.grey; // default color
  Color borderColor = Colors.grey;
  // informações de envio
  String _result = "";
  String _selectItem = "";
  bool envio = false;

  // obtém item selecionado e armazena
  void changeSelectedItem(String e) {
    setState(() {
      _selectItem = e;
      _result = _selectItem;
    });
  }

  // botão de envio
  void _enviar() {
    //obtém informações do usuário
    String nome = _nome.text;
    String email = _email.text;

    // define resposta
    setState(() {
      Navigator.pushReplacementNamed(context, '/telaC');
      _result = '$email $nome';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela A')),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 50),
            SizedBox(
                // label para primeiro número
                width: 300,
                child: TextField(
                  controller: _nome,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Entre com email',
                    prefixIcon: const Icon(Icons.account_circle_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                )),
            const SizedBox(height: 16.0),
            SizedBox(
                // label para primeiro número
                width: 300,
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Entre com senha',
                    prefixIcon: const Icon(Icons.account_circle_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                )),
            const SizedBox(height: 50),
            SizedBox(
                // label para primeiro número
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _enviar,
                      child: const Text('Enviar'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class TelaC extends StatefulWidget {
  @override
  StateC createState() => StateC();
}

class StateC extends State<TelaC> {
  List<dynamic> dataList = [''];
  // método assíncrono para consumir informações de uma api
  Future<void> fetchData() async {
    // realiza a requisição
    final response =
        await http.get(Uri.parse('http://demo1670899.mockable.io/val'));
    // verifica êxito da requisição
    if (response.statusCode == 200) {
      // converte resposta em objeto json
      // final jsonResponse = ;
      
      // atualiza state
      setState(() {
        dataList = jsonDecode(response.body);
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
                title: Text('Name:${item['id']} '), // Nome do usuário.
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username:${item['id']}',
                        style: TextStyle(fontSize: 16)),
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



class TelaD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela D')),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Espaço entre o texto e a imagem
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMyFsZ5sV7Bb2KdP56_lWbKkvxEijuWIlQRw&s',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Pedido Confirmado',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              child: Text('Voltar'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/telaB');
              },
            ),
          ],
        ),
      ),
    );
  }
}
