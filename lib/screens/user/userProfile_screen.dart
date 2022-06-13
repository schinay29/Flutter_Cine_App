import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Session.dart';
import 'package:cine_view/screens/moviedetail_screen.dart';
import 'package:cine_view/screens/user/myCards_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  CineService _cineService = new CineService();
  // File? file;
  // ImagePicker image = ImagePicker();kkkkc

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
        // height: 200,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text('Bienvenido', style: Theme.of(context).textTheme.headline4,),
            SizedBox(height: 20,),
            _buildProfileImg(),
            SizedBox(height: 20,),
            ProfileMenu(text: 'Editar Perfil', icon: Icons.person_outlined, press: () {}),
            SizedBox(height: 10,),
            //ProfileMenu(text: 'Mis pedidos', icon: Icons.event_seat_rounded,press: () {})
            ProfileMenu(text: 'Mis tarjetas', icon: Icons.payment, press: () { Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyCardsScreen()),);}),
            SizedBox(height: 10,),
            ProfileMenu(text: 'Mis pedidos', icon: Icons.shopping_cart_outlined, press: () {}),
            SizedBox(height: 10,),
            ProfileMenu(text: 'Cerrar Sesión', icon: Icons.logout, press: () {}),
          ],
        )
        

        // child: FutureBuilder(
        //   // future: _cineService.getSession(2),
        //   future: _cineService.getMovies(),
        //   builder: (context,  AsyncSnapshot<List<Movie>> snapshot) {
        //     while (snapshot.connectionState == ConnectionState.waiting)
        //       return CircularProgressIndicator();
        //     if (snapshot.connectionState == ConnectionState.done){
        //       if (snapshot.hasData) {
        //         if (snapshot.data != null) movies = snapshot.data!;
        //       }
        //     }
        //     return Column(
        //       children: [
        //         _buildRecentMovies(),
        //         _buildPageIndicator(),
        //         SizedBox(height: 40,),
        //         SingleChildScrollView(
        //           scrollDirection: Axis.horizontal,

        //         child: Row(

        //           children: List.generate(movies.length, ((index) => _buildAllMovies(movies[index]))),
        //         )

        //         )
        //       ],
        //     );
        // },)

        // child: Column(
        //   children: [
        //     _buildRecentMovies(),
        //     _buildPageIndicator(),
        //     _buildAllMovies()
        //   ],
        // ),
      ),
    );
  }

  Widget _buildProfileImg() {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage('https://picsum.photos/250?image=9'),
              ),
              Positioned(
                right: -7,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: ClipOval(
                    child: Material(
                      shadowColor: Colors.grey.shade400,
                      color: Colors.grey.shade300, // Button color
                      child: InkWell(
                        splashColor: Colors.grey.shade400, // Splash color
                        onTap: () {
                          getGallery();
                        },
                        child: SizedBox(width: 56, height: 56, child: Icon(Icons.camera_alt_rounded)),
                        ),
                      ),
                    ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }


  Future getGallery() async {
    await ImagePicker().pickImage(source: ImageSource.gallery);
    // var img = await image.getImage(source: ImageSource.gallery);
    // setState(() {
    //   file = File(img!.path);
    // });
  }

}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key, 
    required this.text, 
    required this.icon, 
    required this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FlatButton(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.grey.shade200,
          onPressed: press,
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 25,),
              Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyText1)),
              Icon(Icons.arrow_forward_ios),
            ]
          ),
        ),
      ),
    );
  }
}
