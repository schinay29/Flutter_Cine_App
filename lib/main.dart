import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/screens/buyout/order_screen.dart';
import 'package:cine_view/screens/movies/home_screen.dart';
import 'package:cine_view/screens/user/addPayment_screen.dart';
import 'package:cine_view/screens/user/userProfile_screen.dart';
import 'package:cine_view/screens/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _indexPage = 0;
  List<Widget> _screens = [HomeScreen(), UserScreen()];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    if (userId != null && userId != '') {
      setState(() {
        _screens = [HomeScreen(), UserProfileScreen()];
      });
    }
  }

  // List<Widget> _screens = [ListMovie(), BuyTicketsScreen()];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    print("pruebaaa");
    return MaterialApp(
      // initialRoute: '/main',
      // routes: {
      //   '/main': (context) => HomeScreen(),
      //   '/second': (context) => BuyTicketsScreen(),
      // },
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
          unselectedItemColor: const Color.fromARGB(137, 126, 124, 124),
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          currentIndex: _indexPage,
          items: const [
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
