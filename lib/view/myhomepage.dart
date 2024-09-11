import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _getData(int id) async {
    var url = Uri.https(
        'fakestoreapi.com', '/products/' + id.toString(), {'q': '{https}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (id == 0 || id > 20) {
      setState(() {
        _counter++;
      });
      print("Número não disponível");
    } else {
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        // var itemCount = jsonResponse['title'];
        // print('Number of books about http: $itemCount.');
        jsonResponse.forEach((produto) => {print(produto['title'])});
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(12)
                ),
              child: Column(
                children: [
                  Image.network('https://colegiosantahelena.com.br/wp-content/uploads/2023/03/Dia_do_Livro_Infantil.webp'),
                  SizedBox(height: 20),
                  Text('Aprendendo a voar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  ),
                  SizedBox(height: 10),
                  Text('20.00', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),),
                  SizedBox(height: 10),
                  Text('Este livro é indicado para crianças a partir de 5 anos de idade',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  ),
                  SizedBox(height: 10),
               ElevatedButton(onPressed: (){}, child: Text('Comprar'))
                ],
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getData(_counter);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
