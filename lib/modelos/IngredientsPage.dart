import 'package:flutter/material.dart';
import 'package:helloworld/main.dart';
import 'AddIngredientPage.dart';
import 'EditIngredientPage.dart';

class IngredientListPage extends StatefulWidget {
  @override
  _IngredientListPageState createState() => _IngredientListPageState();
}

class _IngredientListPageState extends State<IngredientListPage> {
  List<String> ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("Lista de Ingredientes")],
        ),
      ),
      body: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ingredients[index]),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Editar'),
                  value: 'edit',
                ),
                PopupMenuItem(
                  child: Text('Excluir'),
                  value: 'delete',
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  // Navegar para a tela de edição do ingrediente
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditIngredientPage(index, ingredients),
                    ),
                  ).then((value) {
                    // Atualizar a lista de ingredientes com os novos valores após a edição
                    if (value != null) {
                      setState(() {
                        ingredients = value;
                      });
                    }
                  });
                } else if (value == 'delete') {
                  setState(() {
                    ingredients.removeAt(index);
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddIngredientPage()),
              );

              if (result != null) {
                setState(() {
                  ingredients.add(result);
                });
              }
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}
