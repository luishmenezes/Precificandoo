@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromRGBO(114, 133, 202, 1),
    body: Stack(
      children: [
        AnimatedOpacity(
          opacity: isDarkened
              ? 0.7
              : 0.0, // Opacidade controlada pela variável isDarkened
          duration: Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: closeFABMenu, // Fecha o menu ao tocar na tela escura
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
    floatingActionButton: Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height *
            0.03, // Posição vertical ajustável
        left: MediaQuery.of(context).size.width *
            0.05, // Preenchimento esquerdo ajustável
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: isFABOpen,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.14,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Navegar para a tela de ingredientes
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IngredientesScreen(),
                          ),
                        );
                      },
                      backgroundColor: Color.fromRGBO(77, 91, 174, 1),
                      child: Text(
                        "Ingredientes",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.055,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.14,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Navegar para a tela de cardápio
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardapioScreen(),
                          ),
                        );
                      },
                      backgroundColor: Color.fromRGBO(77, 91, 174, 1),
                      child: Text(
                        "Cardápio",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.055,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.022), // Espaço entre o botão flutuante e a animação
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.16,
            height: MediaQuery.of(context).size.width * 0.16,
            child: FloatingActionButton(
              onPressed: () {
                if (!isFABOpen) {
                  showFABMenu();
                } else {
                  closeFABMenu();
                }
              },
              child: Icon(
                isFABOpen ? Icons.close : Icons.add,
                size: MediaQuery.of(context).size.width * 0.08,
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
              backgroundColor: Color.fromRGBO(77, 91, 174, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.08),
              ),
            ),
          ),
        ],
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    bottomNavigationBar: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.078,
          color: Color.fromRGBO(217, 217, 217, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: MediaQuery.of(context).size.width * 0.14,
                  color: Color.fromRGBO(77, 91, 174, 1),
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 0;
                    // Adicione aqui a ação desejada ao pressionar o ícone de home
                  });
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.14,
              ), // Espaçamento entre os ícones
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: MediaQuery.of(context).size.width * 0.14,
                  color: Color.fromRGBO(77, 91, 174, 1),
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 0;
                    // Adicione aqui a ação desejada ao pressionar o ícone de perfil
                  });
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


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
      )