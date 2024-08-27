import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker picker = ImagePicker();

  File? image;

  chooseImages() async {
    final XFile? _image = await picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        image = File(_image.path);
      });
    }
  }

  captureImages() async {
    final XFile? _image = await picker.pickImage(source: ImageSource.camera);
    if (_image != null) {
      setState(() {
        image = File(_image.path);
      });
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
            image != null ? Image.file(image!) : const Icon(Icons.image, size: 150),
            ElevatedButton(
              onLongPress: () {
                chooseImages();
              },
              onPressed: () {
                captureImages();
              },
              child: const Text('Choose / Capture'),
            ),
          ],
        ),
      ),
    );
  }
}
