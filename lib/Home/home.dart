import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textCep = TextEditingController();
  String resultado = "";

  Future<void> _consultarCep() async {
    String cep = textCep.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String city = retorno["localidade"];
    String bairro = retorno["bairro"];

    setState(() {
      resultado = "$logradouro $city $bairro";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: const Center(
          child: Text("Localizador de CEP"),
        ),
        backgroundColor: const Color.fromARGB(255, 89, 203, 93),
      ),
      body: Container(
        child: Column(
          children: [
            Image.asset("images/Localizacao.png"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: textCep,
                keyboardType: TextInputType.number,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: false,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Consultar CEP',
                  labelText: 'CEP',
                  suffixIcon: Icon(Icons.verified_user),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            TextButton(
              child: const Text(
                'Consultar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: _consultarCep,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Resultado: $resultado",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
