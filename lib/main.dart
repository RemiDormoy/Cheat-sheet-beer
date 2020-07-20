import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheatsheetbeer/BiereRepository.dart';
import 'package:flutter/material.dart';

import 'biere.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toutes les bières du monde !',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Biere> _bieres = [];

  @override
  void initState() {
    BiereRepository.getInstance().getBieres().then(_rafraichitBieres);
    super.initState();
  }

  _rafraichitBieres(List<Biere> bieres) {
    setState(() {
      _bieres = bieres;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemBuilder: _celluleDeBiere,
        itemCount: _bieres.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _celluleDeBiere(BuildContext context, int position) {
    var biere = _bieres[position];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: biere.image,
                  height: 130,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(biere.nom, style: TextStyle(color: Colors.white, fontSize: 18),),
                ),
                Text(biere.pays + " | " + biere.prix, style: TextStyle(color: Colors.white.withOpacity(0.5)),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
