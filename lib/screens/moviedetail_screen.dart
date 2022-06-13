import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Actor.dart';
import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Session.dart';
import 'package:cine_view/screens/buyout/buyTickets_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen(this.movie);
  
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  CineService _cineService = new CineService();
  late Movie movie;
  List<Actor> cast = [];

void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rating : ' + widget.movie.starRating.toString());
    return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     leading: BackButton(color: Colors.black),
    //   ),
      body: Stack(
        children: [
          //image background
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              // height: 350,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.movie.img))
              ),

          )),
          // back icon
          Positioned(
            top: 25,
            left: 10,
                child: GestureDetector(
                  onTap: () => {
                      print('taptaptap'),
                      Navigator.of(context, rootNavigator: true).pop(context)
                     // Navigator.pop(globalContext)
                  },
                  child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.amber, size: 16,),
                  ),
                )
          ),
          // movie details info
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.38,
            // top:imageSize ,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top:20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.movie.name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Wrap(
                        // if starrating has value return star all : star border 
                        children: List.generate(5, (index) {return Icon(Icons.star, color: index<widget.movie.starRating?Colors.amber: Colors.black45,);}, growable: true),
                      ),
                      SizedBox(width: 10,),
                      Text('(' + widget.movie.starRating.toString() + '.0)' ),                    
                    ],
                  ),
                      SizedBox(height: 10,),
                       Wrap(
                        children: List<Widget>.generate(3, (int index) {
                          SizedBox(height: 10,);
                          return Chip(
                            label: Text('Item $index'),
                          );
                        },
                      ).toList(),
                    ),
                  SizedBox(height: 10,),
                  Text(widget.movie.description),
                  SizedBox(height: 10,),
                  Text('Cast'),
                  Wrap(
                    children: [
                      FutureBuilder<List<Actor>>(
                        future: _cineService.getCast(widget.movie.movieId),
                        builder: (context, snapshot) {
                          while (snapshot.connectionState == ConnectionState.waiting)
                            return CircularProgressIndicator();
                          if (snapshot.connectionState == ConnectionState.done) cast = snapshot.data!;
                          return Wrap(
                            children: List.generate(cast.length, (index){
                              return CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(cast[index].url)
                              );
                            }
                          )
                          );
                        
                        }
                      ),
                      
                    ],
                    
                    // children: List.generate(5, (index){
                    //   return CircleAvatar(
                    //     radius: 25,
                    //     backgroundColor: Colors.transparent,
                    //     backgroundImage: NetworkImage(widget.movie.img)
                    //   );
                    // })
                  ),
                  SizedBox(height: 10,),
                  // bottom buttons 
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.black)
                            ),
                            child: IconButton(
                              
                              icon: Icon(Icons.favorite_border),
                              onPressed: (){
                                print("save favorite movie");
                              }, 
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                color: Colors.blue,
                                onPressed: (){
                                  //Navigator.of(context).pop();
                                  //push failed, see error
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(builder: (context) => BuyTicketsScreen()));
                                  //Navigator.pop(context);
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => BuyTicketsScreen()),
                                    (Route<dynamic> route) => false);
                                  //Navigator.pushNamed(context, '/second');

                                },
                                child: Text("Comprar tickets".toUpperCase(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),),
                              ),
                            ),
                          ),

                        ],
                      ),


                ],
              ),
            )
          ),
        ],
      ),
    );
  }

  

}
