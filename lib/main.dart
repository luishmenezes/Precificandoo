import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Center,
        Colors,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        ElevatedButton,
        FloatingActionButton,
        Icon,
        Icons,
        InputDecoration,
        ListTile,
        ListView,
        MainAxisAlignment,
        MaterialApp,
        MaterialPageRoute,
        Navigator,
        Padding,
        PopupMenuButton,
        PopupMenuItem,
        Row,
        Scaffold,
        SizedBox,
        State,
        StatefulWidget,
        StatelessWidget,
        Text,
        TextEditingController,
        TextField,
        TextInputType,
        ThemeData,
        Widget,
        runApp;

import 'package:helloworld/modelos/IngredientsPage.dart';
import 'package:helloworld/modelos/AddIngredientPage.dart';
import 'package:helloworld/modelos/EditIngredientPage.dart';
import 'package:helloworld/modelos/navbar.dart';
import 'modelos/navbar.dart';

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Esta é a página Home'),
      ),
    );
  }
}
