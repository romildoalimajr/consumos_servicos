import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();

  String _resultado = "Resultado";

  _recuperarCep() async{
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";

    http.Response response;

    response = await http.get (Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    setState((){
      _resultado = "${logradouro}, ${complemento}, ${bairro}, ${localidade}, ${uf} ";
    });

    print(
      "Resposta logradouro: ${logradouro} - Complemento: ${complemento} - "
          "Bairro: ${bairro} - Localidade: ${localidade} - Estado: ${uf}"
    );

    //print("resposta: " + response.statusCode.toString());
    //print("resposta: " + response.body);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço Web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep: ex: 05428200"
              ),
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
                child: Text("Clique aqui!"),
                onPressed: _recuperarCep,
            ),
            Text(
              _resultado,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
