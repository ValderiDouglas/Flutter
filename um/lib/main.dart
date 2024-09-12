import 'package:flutter/material.dart';

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
  FormsState createState() => FormsState();
}

class TelaB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Lista de Produtos')),
        body: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 20), // Para dar um espaço da AppBar
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('item 1'),
                    onTap: () {
                      Navigator.pushNamed(context, '/telaC',
                          arguments: 'item 1');
                    },
                  ),
                  ListTile(
                    title: Text('item 2'),
                    onTap: () {
                      Navigator.pushNamed(context, '/telaC',
                          arguments: 'item 2');
                    },
                  ),
                  ListTile(
                    title: Text('item 3'),
                    onTap: () {
                      Navigator.pushNamed(context, '/telaC',
                          arguments: 'item 3');
                    },
                  ),
                ],
              ),
            )));
  }
}

class TelaC extends StatefulWidget {
  @override
  Itens createState() => Itens();
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

class FormsState extends State<TelaA> {
  //define conteúdo de listView

  // controller para input nome
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
      Navigator.pushReplacementNamed(context, '/telaB');
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
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMyFsZ5sV7Bb2KdP56_lWbKkvxEijuWIlQRw&s',
              width: 200,
              height: 200,
            ),
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
            const Divider(),
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

class Itens extends State<TelaC> {
  //define conteúdo de listView

  // controller para input nome
  final TextEditingController _quantidade = TextEditingController();
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
    String nome = _quantidade.text;
    String selecionado = _selectItem;

    // define resposta
    setState(() {
      _result = '$selecionado $nome';
      Navigator.pushReplacementNamed(context, '/telaD');
    });
  }

  // cancela
  void _cancelar() {
    _quantidade.text = "";
    String nome = _quantidade.text;
    String sel = _selectItem;

    // define resposta
    setState(() {
      _result = '$sel $nome';
    });
  }

  @override
  Widget build(BuildContext context) {
    final String produto = ModalRoute.of(context)?.settings.arguments as String;
    final TextEditingController _nome = TextEditingController(text: produto);

    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da compra')),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                width: 300,
                child: TextField(
                  controller:
                      _nome, // Aqui o controlador já está com o texto inicial
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Entre com a quantidade',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            SizedBox(
                // label para primeiro número
                width: 300,
                child: TextField(
                  controller: _quantidade,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Entre com a quantidade',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _enviar,
                      child: const Text('Enviar'),
                    ),
                    ElevatedButton(
                      onPressed: _cancelar,
                      child: const Text('Cancelar'),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
