import 'package:cine_view/screens/buyout/buyTickets_screen.dart';
import 'package:cine_view/screens/home_screen.dart';
import 'package:cine_view/screens/movies/List.dart';
import 'package:cine_view/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _indexPage = 0;
  // List<Widget> _screens = [ListMovie(), BuyTicketsScreen()];
  List<Widget> _screens = [HomeScreen(), BuyTicketsScreen()];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    print("pruebaaa");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _screens[_indexPage],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _indexPage = index;
            });
          },
          unselectedItemColor: Color.fromARGB(137, 126, 124, 124),
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          currentIndex: _indexPage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.scale_sharp), label: "Promociones"),
            // BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle), label: "Usuarios")
          ],
        ),
      ),
    );
  }
}
