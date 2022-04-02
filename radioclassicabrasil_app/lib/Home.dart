import 'package:radioclassicabrasilapp/customSearchDelegate.dart';
import 'package:flutter/material.dart';

import 'telas/Biblioteca.dart';
import 'telas/EmAlta.dart';
import 'telas/Inicio.dart';
import 'telas/Inscricao.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      EmAlta(),
      Inicio(_resultado),
      Biblioteca(),
      Inscricao()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "imagens/classicalogoapp.png",
          width: 98,
          height: 92,
        ),
        actions: <Widget>[

          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String res = await showSearch(
                    context: context, delegate: CustomSearchDelegate());
                setState(() {
                  _resultado = res;
                });
                print("resultado: digitado " + res);
              }
          ),

          /*
          IconButton(
              icon: Icon(Icons.videocam),
              onPressed: (){
                print("acao: videocam");
          }
              ),

          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: (){
                print("acao: conta");
              }
          )

           */
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _indiceAtual,
          onTap: (indice) {
            setState(() {
              _indiceAtual = indice;
            });
          },
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
              //backgroundColor: Colors.orange,
                title: Text("Rádio"),
                icon: Icon(Icons.radio)
            ),
            BottomNavigationBarItem(
              //backgroundColor: Colors.red,
                title: Text("Vídeo"),
                icon: Icon(Icons.video_label)
            ),
            BottomNavigationBarItem(
              //backgroundColor: Colors.blue,
                title: Text("Social"),
                icon: Icon(Icons.menu)
            ),
            BottomNavigationBarItem(
              //backgroundColor: Colors.green,
                title: Text("Parceiros"),
                icon: Icon(Icons.flare)
            ),
          ]
      ),
    );
  }
}