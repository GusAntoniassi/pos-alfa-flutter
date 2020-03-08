import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ContatoPage extends StatefulWidget {
  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final nomeController = new TextEditingController();
  final telefoneController = new TextEditingController();
  final emailController = new TextEditingController();
  final mensagemController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Contato"),
        centerTitle: true,
        backgroundColor: Color(0xFF000077),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              criarCampoTexto("Nome", nomeController, TextInputType.text),
              criarCampoTexto("Telefone", telefoneController, TextInputType.phone),
              criarCampoTexto("E-mail", emailController, TextInputType.emailAddress),
              criarCampoTexto("Mensagem", mensagemController, TextInputType.text),
              RaisedButton(
                color: Color(0xFF000077),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.send, size: 26, color: Colors.white),
                    Text("Enviar", style: TextStyle(fontSize: 22, color: Colors.white))
                  ],
                ),
                onPressed: enviarEmail,
              )
            ],
          ),
        )
      )
    );
  }

  void enviarEmail() async {
    String userName = "gus.antoniassi@gmail.com";
    String password = "SENHA";

    final smtpServer = gmail(userName, password);
    final mensagem = new Message();
    mensagem.from = Address(userName, "Flutter App");
    mensagem.recipients.add(userName);
    mensagem.subject = "Contato do app Etanol x Gasolina";
    mensagem.text = "Nome: ${nomeController.text}."
      "Email: ${emailController.text}"
      "Telefone: ${telefoneController.text}"
      "Mensagem: ${mensagemController.text}"
    ;

    final sendReports = await send(mensagem, smtpServer);

    // Atualizar valores da tela com setState
    setState(() {
      nomeController.text = "";
      telefoneController.text = "";
      emailController.text = "";
      mensagemController.text = "";
    });
  }

  Widget criarCampoTexto(String texto, TextEditingController c, TextInputType t) {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextField(
      controller: c,
      keyboardType: t,
      decoration: InputDecoration(
        labelText: texto,
        labelStyle: TextStyle(color: Color(0xFF000077)),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Color(0xFF000077), fontSize: 18),
      )
    );
  }
}
