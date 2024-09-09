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
        '/telaD' : (context) => TelaD()
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
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    return Scaffold(
      appBar: AppBar(title: Text('Tela B')),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'ListView Options',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true, // if scroll
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    //leading: Image(image: items[index]),
                    title: Text(items[index]),
                    //subtitle: Text(items[index]),
                    onLongPress: () {
                      Navigator.pushReplacementNamed(context, '/TelaC');
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              child: Text('Voltar para Tela A'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
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
      body: Center(
        child: ElevatedButton(
          child: Text('Voltar'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/TelaB');
          },
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

    // altera state textColor
    void changeTextColor(Color newColor) {
      setState(() {
        textColor = newColor;
      });
    }

    // altera cor da borda
    void changeBorderColor(Color newColor) {
      setState(() {
        borderColor = newColor;
      });
    }

    // define resposta
    setState(() {
      if (nome == "" || email == "") {
        changeTextColor(Colors.red);
        if (nome == "") {
          _result = "Campo nome obrigatório";
        } 
        if (email == "") {
          _result = "Campo Item obrigatório";
        }      

        //altera cor da borda para indicar
        changeBorderColor(Colors.red);        
      } else {
        Navigator.pushReplacementNamed(context, '/telaB');
        _result = '$email $nome';
      }
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
            const Text(
              'Sample Input',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
            const SizedBox(height: 16.0),
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
            !envio
                ? SizedBox(
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
                    ))
                : const SizedBox.shrink(),   
            
         
          ],
        ),
      ),
    );
  }
}

class Itens extends State<TelaC> {
  //define conteúdo de listView

  // controller para input nome
  final TextEditingController _nome = TextEditingController();
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
    String selecionado = _selectItem;

    // altera state textColor
    void changeTextColor(Color newColor) {
      setState(() {
        textColor = newColor;
      });
    }

    // altera cor da borda
    void changeBorderColor(Color newColor) {
      setState(() {
        borderColor = newColor;
      });
    }

    void changeEnvio(bool e) {
      setState(() {
        envio = e;
      });
    }

    // define resposta
    setState(() {
      if (nome == "" || selecionado == "") {
        changeTextColor(Colors.red);
        if (nome == "") {
          _result = "Campo nome obrigatório";
        } else if (selecionado == "") {
          _result = "Campo Item obrigatório";
        }
        //altera cor da borda para indicar
        changeBorderColor(Colors.red);
      } else {
        changeEnvio(true);
        changeTextColor(Colors.red);
        changeBorderColor(Colors.grey);

        _result = nome;
        _selectItem = selecionado;
        _result = '$selecionado $nome';
      }
    });
  }

  // cancela
  void _cancelar() {
    _nome.text = "";
    String nome = _nome.text;
    String sel = _selectItem;

    // define resposta
    setState(() {
      _result = '$sel $nome';
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
            const Text(
              'Sample Input',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
                // label para primeiro número
                width: 300,
                child: TextField(
                  controller: _nome,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Entre com nome',
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
            const Divider(),
            !envio
                ? SizedBox(
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
                : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
            Text(
              'Resposta: $_result',
              style: TextStyle(fontSize: 24.0, color: textColor),
            ),
            ElevatedButton(
          child: Text('Ir para Tela B'),
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
