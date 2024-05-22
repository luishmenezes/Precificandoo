import 'package:flutter/material.dart';

class telaPrincipal extends StatelessWidget {
  const telaPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Text("INSUMOS")]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("clicou no mais");
          },
          child: const Icon(Icons.add),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Adicione aqui os seus insumos",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ));
  }
}
