import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumiendo el API Dogs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogImagePage(),
    );
  }
}

class DogImagePage extends StatefulWidget {
  @override
  _DogImagePageState createState() => _DogImagePageState();
}

class _DogImagePageState extends State<DogImagePage> {
  final List<int> statusCodes = [100, 200, 300, 400, 404, 500, 502, 503, 504];
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    fetchRandomDogImage();
  }

  void fetchRandomDogImage() {
    final random = Random();
    final statusCode = statusCodes[random.nextInt(statusCodes.length)];
    setState(() {
      imageUrl = 'https://http.dog/$statusCode.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API DOGS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 400, // Ajusta el ancho de la imagen
                    height: 400, // Ajusta la altura de la imagen
                    fit: BoxFit.cover, // Ajusta la imagen dentro del cuadro
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchRandomDogImage,
              child: Text('Cargar otra imagen de perro'),
            ),
          ],
        ),
      ),
    );
  }
}