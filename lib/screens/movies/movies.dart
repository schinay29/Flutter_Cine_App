import 'dart:convert';
import 'package:cine_view/screens/user/create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cine_view/constants/base_api.dart';
import 'package:cine_view/theme/theme_colors.dart';
import 'package:http/http.dart' as http;

class ListMovie extends StatefulWidget {
  @override
  _ListMovieState createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  List movies = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loadMovies();
  }

  loadMovies() async {
    setState(() {
      isLoading = true;
    });
    var url = BASE_API + "movie";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        movies = items;
        isLoading = false;
      });
    } else {
      setState(() {
        movies = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Peliculas"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (movies.contains(null) || movies.length < 0 || isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return getCard(movies[index]);
        });
  }

  Widget getCard(item) {
    return miCardImage(item);
  }
  // Widget getCard(item) {
  //   var title = item['name'];
  //   return Card(
  //     child: ListTile(
  //       title: Text(
  //         title,
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //     color: Colors.green,
  //   );
  // }

  Card miCard(item) {
    return Card(
      // Con esta propiedad modificamos la forma de nuestro card
      // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      // Con esta propiedad agregamos margen a nuestro Card
      // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
      margin: EdgeInsets.all(15),

      // Con esta propiedad agregamos elevación a nuestro card
      // La sombra que tiene el Card aumentará
      elevation: 10,

      // La propiedad child anida un widget en su interior
      // Usamos columna para ordenar un ListTile y una fila con botones
      child: Column(
        children: <Widget>[
          // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text(item['name']),
            subtitle: Text(item['description']),
            leading: Icon(Icons.home),
          ),

          // Usamos una fila para ordenar los botones del card
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(onPressed: () => {}, child: Text('Aceptar')),
              FlatButton(onPressed: () => {}, child: Text('Cancelar'))
            ],
          )
        ],
      ),
    );
  }

  Card miCardImage(item) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: EdgeInsets.all(15),
        elevation: 10,

        // Dentro de esta propiedad usamos ClipRRect
        child: ClipRRect(
          // Los bordes del contenido del card se cortan usando BorderRadius
          borderRadius: BorderRadius.circular(30),

          // EL widget hijo que será recortado segun la propiedad anterior
          child: Column(
            children: <Widget>[
              // Usamos el widget Image para mostrar una imagen
              Image(
                // Como queremos traer una imagen desde un url usamos NetworkImage
                image: NetworkImage(item['img']),
              ),

              // Usamos Container para el contenedor de la descripción
              Container(
                padding: EdgeInsets.all(10),
                child: Text(item['name']),
              ),
            ],
          ),
        ));
  }
}
