import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tb_logistics_app/pages/travels_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String? _placa;
  late String? _password;

  @override
  void initState() {
    super.initState();
    getLocalCredential().then((value) {
      setState(() {
        _placa = value[0];
        _password = value[1];
      });
    });
  }

  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tb Transportes - Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image(
                      image: NetworkImage(
                          'https://www.cbbasfaltos.com.br/images/logo.png'),
                    )),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  initialValue: _placa,
                  controller: _placaController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Placa',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Digite sua placa'),
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  initialValue: _password,
                  controller: _passwordController,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Digite sua senha'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
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
    String placa = credentialBox.get('placa');
    String password = credentialBox.get('password');

    print(placa);
    print(password);
    return [placa, password];
  }
}
