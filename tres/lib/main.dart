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
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 150),
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

  void _enviar() async {
    // Obtém informações do usuário
    String nome = _nome.text;
    String email = _email.text;

    // Cria um mapa com os dados
    Map<String, String> data = {
      'nome': nome,
      'email': email,
    };

    // Define a URL
    String url = 'http://demo7630410.mockable.io/login';

    try {
      // Envia os dados em formato JSON
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 3)); // Timeout de 3 segundos

      // Verifica se a requisição foi bem-sucedida
      if (response.statusCode == 200) {
        // Exibe a resposta
        final jsonResponse = json.decode(response.body);
        setState(() {
          _result = jsonResponse['token'];
        });

        // Navega para a telaC após 3 segundos
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, '/telaC');
      } else {
        // Lida com erro da resposta
        setState(() {
          _result = 'Erro: ${response.statusCode}';
        });
      }
    } catch (e) {
      // Lida com exceções (como timeout)
      setState(() {
        _result = 'Erro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 200),
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
            _result != ""
                ? Text('Token: ${_result}')
                : const SizedBox.shrink(), // espaço vazio
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
  List<dynamic> dataList = [];

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://demo7630410.mockable.io/notasAlunos'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        dataList = jsonResponse['data'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _menor60() {
    setState(() {
      dataList = dataList.where((element) => element['nota'] < 60).toList();
    });
  }

  void _maior60() {
    setState(() {
      dataList = dataList
          .where((element) => element['nota'] >= 60 && element['nota'] < 100)
          .toList();
    });
  }

  void _100() {
    setState(() {
      dataList = dataList.where((element) => element['nota'] == 100).toList();
    });
  }

  void _reload() {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length, // Number of items in the list.
                itemBuilder: (BuildContext context, int index) {
                  final item = dataList[index]; // Current item from the list.
                  // Returns a container with conditional styling based on 'nota'.
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: item['nota'] < 60
                          ? const Color.fromARGB(255, 207, 204, 0)
                          : item['nota'] >= 60 && item['nota'] < 100
                              ? const Color.fromARGB(255, 2, 153, 177)
                              : const Color.fromARGB(
                                  255, 25, 221, 7), // Alternating colors.
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded borders.
                    ),
                    child: ListTile(
                      title: Text('Nome: ${item['nome']}'), // User's name.
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nota: ${item['nota']}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    // Button row
                    width: 700,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _menor60,
                          child: const Text('<60'),
                        ),
                        ElevatedButton(
                          onPressed: _maior60,
                          child: const Text('>=60'),
                        ),
                        ElevatedButton(
                          onPressed: _100,
                          child: const Text('100'),
                        ),
                        ElevatedButton(
                          onPressed: _reload,
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
