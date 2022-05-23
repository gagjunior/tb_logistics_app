import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tb_logistics_app/pages/travels_list_page.dart';

const SizedBox spacer = SizedBox(
  height: 20,
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
    getLocalCredential().then((value) {
      setState(() {
        _placaController.text = value[0] ?? '';
        _passwordController.text = value[1] ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tb Transportes - Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('images/icone_logo_cbb.png')),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 500,
              child: Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  cursorColor: Colors.yellow[800],
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _placaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Placa',
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: 'Digite sua placa',
                    prefix: Icon(
                      Icons.abc_rounded,
                      color: Colors.blue[400],
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            spacer,
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  cursorColor: Colors.yellow[800],
                  controller: _passwordController,
                  obscureText: _showPassword,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Senha',
                    labelStyle: const TextStyle(fontSize: 20),
                    hintText: 'Digite sua senha',
                    prefix: Icon(
                      Icons.password_rounded,
                      color: Colors.blue[400],
                      size: 30,
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        !_showPassword ? Icons.lock : Icons.lock,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.blue[900];
                  }
                })),
                onPressed: () {
                  if (_placaController.text == '') {
                    _showDialogLogin(
                        'Erro de Placa', 'Placa não pode estar em branco!');
                    return;
                  }
                  if (_passwordController.text == '') {
                    _showDialogLogin(
                        'Erro de Senha', 'Senha não pode estar em branco');
                    return;
                  }
                  compareCredentialSaved(
                      _placaController.text, _passwordController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TravelListPage()));
                },
                child: const Text(
                  'Acessar',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String?>> getLocalCredential() async {
    Box credentialBox = await Hive.openBox('credentialBox');
    String placa = await credentialBox.get('placa');
    String password = await credentialBox.get('password');
    return [placa, password];
  }

  void compareCredentialSaved(String placa, String password) async {
    Box credentialBox = await Hive.openBox('credentialBox');
    String? placaSaved;
    String? passwordSaved;
    await getLocalCredential().then((value) {
      placaSaved = value[0];
      passwordSaved = value[1];
    });
    if (placa != placaSaved || password != passwordSaved) {
      credentialBox
          .putAll({'placa': placa.toUpperCase(), 'password': password});
    }
  }

  void _showDialogLogin(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actionsOverflowButtonSpacing: 6,
        title: Text(title),
        titleTextStyle: TextStyle(
          color: Colors.blue[800],
          fontSize: 25,
        ),
        content: Text(content),
        contentTextStyle: TextStyle(color: Colors.red, fontSize: 20),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Voltar'),
          )
        ],
      ),
    );
  }
}
