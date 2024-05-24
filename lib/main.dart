import 'package:flutter/material.dart';

import 'package:helloworld/modelos/IngredientsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Ingredientes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IngredientListPage(),
    );
  }
}
