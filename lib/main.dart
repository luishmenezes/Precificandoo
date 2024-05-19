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

class AddIngredientPage extends StatefulWidget {
  @override
  _AddIngredientPageState createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController totalCostPriceController =
      TextEditingController();

  double costPricePerUnit = 0.0;
  double totalCostPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Ingrediente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do Ingrediente'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantidade Comprada'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                calculateTotalCostPrice();
              },
            ),
            TextField(
              controller: totalCostPriceController,
              decoration: InputDecoration(labelText: 'Preço de Compra Total'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                calculateCostPricePerUnit();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Obter os novos valores dos campos
                String name = nameController.text;
                String quantity = quantityController.text;
                String ingredient =
                    '$name - $quantity - R\$$totalCostPrice - R\$$costPricePerUnit';
                // Adicionar à lista de ingredientes e voltar para a página anterior
                Navigator.pop(context, ingredient);
              },
              child: Text('Adicionar Ingrediente'),
            ),
          ],
        ),
      ),
    );
  }

  void calculateCostPricePerUnit() {
    setState(() {
      double quantity = double.tryParse(quantityController.text) ?? 0.0;
      totalCostPrice = double.tryParse(totalCostPriceController.text) ?? 0.0;
      if (quantity != 0.0) {
        costPricePerUnit = totalCostPrice / quantity;
      } else {
        costPricePerUnit = 0.0;
      }
    });
  }

  void calculateTotalCostPrice() {
    setState(() {
      double quantity = double.tryParse(quantityController.text) ?? 0.0;
      double price = double.tryParse(totalCostPriceController.text) ?? 0.0;
      totalCostPrice = quantity * price;
    });
  }
}

class EditIngredientPage extends StatefulWidget {
  final int index;
  final List<String> ingredients;

  EditIngredientPage(this.index, this.ingredients);

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController totalCostPriceController;

  double costPricePerUnit = 0.0;
  double totalCostPrice = 0.0;

  @override
  void initState() {
    super.initState();
    List<String> ingredientParts =
        widget.ingredients[widget.index].split(' - ');
    nameController = TextEditingController(text: ingredientParts[0]);
    quantityController = TextEditingController(text: ingredientParts[1]);
    totalCostPriceController =
        TextEditingController(text: ingredientParts[2].replaceAll(' ', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Ingrediente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do Ingrediente'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantidade Comprada'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                calculateCostPricePerUnit();
              },
            ),
            TextField(
              controller: totalCostPriceController,
              decoration: InputDecoration(labelText: 'Preço de Compra Total'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                calculateCostPricePerUnit();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Obter os novos valores dos campos
                String name = nameController.text;
                String quantity = quantityController.text;
                String totalCostPrice = totalCostPriceController.text;

                // Montar o ingrediente atualizado
                String updatedIngredient =
                    '$name - $quantity - $totalCostPrice - $costPricePerUnit';
                // Atualizar a lista de ingredientes com o ingrediente atualizado
                widget.ingredients[widget.index] = updatedIngredient;
                // Voltar para a página anterior com a lista atualizada de ingredientes
                Navigator.pop(context, widget.ingredients);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void calculateCostPricePerUnit() {
    setState(() {
      double quantity = double.tryParse(quantityController.text) ?? 0.0;
      totalCostPrice = double.tryParse(totalCostPriceController.text) ?? 0.0;
      if (quantity != 0.0) {
        costPricePerUnit = totalCostPrice / quantity;
      } else {
        costPricePerUnit = 0.0;
      }
    });
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
