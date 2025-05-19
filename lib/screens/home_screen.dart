import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:sinema_app/const/url.dart';
import 'package:sinema_app/model/crousle_model.dart';
import 'package:sinema_app/model/movie_model.dart';
import 'package:sinema_app/model/star_model.dart';
import 'package:sinema_app/screens/detail_screen.dart';
import 'package:sinema_app/screens/image_full.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CrousleModel> crousleList = [];
  List<MovieModel> movieList1 = [];
  List<MovieModel> movieList2 = [];
  List<StarModel> starList = [];

  callCrousleApi() async {
    final uri = Uri.parse('$movieUrl=pageviewmovie');
    final Response response = await get(uri);
    print(response.body);
    final data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      setState(() {
        crousleList.add(
          CrousleModel(
            id: data[i]['id'],
            img_slide: data[i]['img_slide'],
            name: data[i]['name'],
          ),
        );
      });
    }
  }

  callMovieApi(String inPutUrl, List<MovieModel> movieList) async {
    final uri = Uri.parse('$movieUrl=$inPutUrl');
    final Response response = await get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var i = 0; i < data.length; i++) {
        setState(() {
          movieList.add(
            MovieModel(
              id: data[i]['id'],
              name: data[i]['name'],
              description: data[i]['description'],
              saleSakht: data[i]['saleSakht'],
              price: data[i]['price'],
              image_url: data[i]['image_url'],
              keshvar: data[i]['image_url'],
              zaman: data[i]['zaman'],
            ),
          );
        });
      }
    }
  }

  callApiStar() async {
    final uri = Uri.parse('$movieUrl=stars');
    final Response response = await get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var i = 0; i < data.length; i++) {
        setState(() {
          starList.add(
            StarModel(
              id: data[i]['id'],
              name: data[i]['name'],
              pic: data[i]['pic'],
            ),
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    callCrousleApi();
    callMovieApi('movie1', movieList1);
    callMovieApi('movie2', movieList2);
    callApiStar();
  }

  Widget build(BuildContext context) {
    Size width = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            crousleList.isEmpty
                ? const Center(
                  child: SpinKitSpinningLines(color: Colors.white, size: 50.0),
                )
                : CarouselList(crousleList: crousleList, width: width),
            textBar('فیلم های پرطرفدار', 'بیشتر >'),
            MovieList(width: width, movieList: movieList1),

            textBar('بازیگران', 'بیشتر >'),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: starList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 120,
                    height: 120,
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(250),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(250),
                            child: FadeInImage(
                              placeholder: AssetImage('assets/images/logo.png'),
                              image: NetworkImage(starList[index].pic),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          starList[index].name,
                          style: TextStyle(
                            fontFamily: 'YekanBakh',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            textBar('تازه ترین ها', 'بیشتر >'),
            MovieList(width: width, movieList: movieList2),
          ],
        ),
      ),
    );
  }

  Padding textBar(String name, String more) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Lalezar',
            ),
          ),
          Text(
            more,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: 'YekanBakh',
            ),
          ),
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.width, required this.movieList});

  final Size width;
  final List<MovieModel> movieList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.width,
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 175,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageFull(id: movieList[index].id),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                    right: 8,
                    left: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Hero(
                          tag: 'imageHero${movieList[index].id}',
                          child: Material(
                            color: Colors.transparent,
                            child: FadeInImage(
                              placeholder: AssetImage('assets/images/logo.png'),
                              image: NetworkImage(movieList[index].image_url),
                              width: 150,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        maxLines: 1,
                        movieList[index].name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: 'YekanBakh',
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${movieList[index].price}.000 تومان ',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: 'YekanBakh',
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: width.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        DetailScreen(id: movieList[index].id),
                              ),
                            );
                          },
                          child: Text(
                            'بیشتر',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'YekanBakh',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CarouselList extends StatelessWidget {
  const CarouselList({
    super.key,
    required this.crousleList,
    required this.width,
  });

  final List<CrousleModel> crousleList;
  final Size width;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: crousleList.length,
      itemBuilder:
          (BuildContext context, int itemIndex, int pageViewIndex) => Stack(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    crousleList[itemIndex].img_slide,
                    width: width.width * 0.9,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: Text(
                    crousleList[itemIndex].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        initialPage: 1,
        viewportFraction: 0.95,
      ),
    );
  }
}
