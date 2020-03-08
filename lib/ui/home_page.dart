import 'package:aula0107032020/ui/contato_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

const int MAIN_COLOR = 0xFF000077;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final etanolController = new TextEditingController();
  final gasolinaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Etanol X Gasolina"),
          centerTitle: false,
          backgroundColor: Color(MAIN_COLOR),
          actions: <Widget>[
            criarBotaoBarra(Icons.share, compartilhar),
            criarBotaoBarra(Icons.mail, abrirContato)
          ],
        ),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Text(
                  "Etanol X Gasolina",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                decoration: BoxDecoration(color: Color(MAIN_COLOR))),
            criarItemLista(Icons.share, "Compartilhar", compartilhar),
            criarItemLista(Icons.mail, "Contato", abrirContato),
          ],
        )),
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            criarCampoTexto("Etanol", "R\$ ", etanolController),
            criarCampoTexto("Gasolina", "R\$ ", gasolinaController),
            Padding(
                padding: EdgeInsets.fromLTRB(50, 16, 50, 16),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.swap_horiz, color: Colors.white, size: 26),
                      Text(" Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ))
                    ],
                  ),
                  onPressed: calcular,
                ))
          ],
        ),
        backgroundColor: Colors.white);
  }

  void compartilhar() {
    Share.share(
        "Etanol: ${etanolController.text}, Gasolina: ${gasolinaController.text}");
  }

  void abrirContato() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContatoPage()));
  }

  void calcular() {
    if (etanolController.text.isEmpty) {
      showMessage("Atenção", "Digite o valor do Etanol!");
      return;
    }
    if (gasolinaController.text.isEmpty) {
      showMessage("Atenção", "Digite o valor da Gasolina!");
      return;
    }

    double valorEtanol = double.parse(etanolController.text);
    double valorGasolina = double.parse(gasolinaController.text);

    if (valorEtanol <= (valorGasolina * 0.7)) {
      showMessage("Etanol", "O etanol é mais vantajoso!");
    } else {
      showMessage("Gasolina", "A gasolina é mais vantajosa!");
    }
  }

  void showMessage(String titulo, String texto) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(texto),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Widget criarBotaoBarra(IconData icon, Function func) {
    return IconButton(
        icon: Icon(icon, color: Colors.white, size: 32), onPressed: func);
  }

  Widget criarItemLista(IconData icon, String titulo, Function func) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Color(MAIN_COLOR), size: 32),
          Padding(
            padding: EdgeInsets.only(left: 8),
              child: Text(titulo, style: TextStyle(color: Color(MAIN_COLOR), fontSize: 18))
          )
        ],
      ),
      onTap: func,
    );
  }

  Widget criarCampoTexto(
      String label, String prefixo, TextEditingController ctrl) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(MAIN_COLOR), fontSize: 24),
          border: OutlineInputBorder(),
          prefixText: prefixo,
        ),
        style: TextStyle(color: Color(MAIN_COLOR)),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
