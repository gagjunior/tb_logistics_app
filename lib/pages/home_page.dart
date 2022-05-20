import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tb_logistics_app/pages/travels_list_page.dart';

const SizedBox spacer = SizedBox(
  height: 20,
);

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              padding: EdgeInsets.only(top: 60.0),
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
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 500,
              child: Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autofocus: true,
                  controller: _placaController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Placa',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Digite sua placa'),
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
                  controller: _passwordController,
                  obscureText: _showPassword,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: 'Digite sua senha',
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
    String placa = await credentialBox.get('placa');
    String password = await credentialBox.get('password');
    return [placa, password];
  }
}
