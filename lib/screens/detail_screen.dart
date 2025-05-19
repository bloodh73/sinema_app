import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:sinema_app/const/url.dart';
import 'package:sinema_app/model/movie_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  MovieModel? movieModel;

  callDetailApi(String id) async {
    final url = Uri.parse('$movieUrl=getMovieData&id=$id');
    final Response response = await get(url);

    if (response.statusCode == 200 && mounted) {
      final data = jsonDecode(response.body);
      setState(() {
        movieModel = MovieModel(
          id: data['id'],
          name: data['name'],
          description: data['description'],
          saleSakht: data['saleSakht'],
          price: data['price'],
          image_url: data['image_url'],
          keshvar: data['keshvar'],
          zaman: data['zaman'],
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    callDetailApi(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
          movieModel == null
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitThreeBounce(color: Colors.green, size: 50.0),
                    SizedBox(height: 10),
                    Text(
                      'درحال بارگذاری',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontFamily: 'Lalezar',
                      ),
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 390,
                      width: width,
                      child: Image.network(
                        movieModel!.image_url,

                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movieModel!.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'قیمت: ${movieModel!.price},000 تومان',
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                          SizedBox(height: 16),
                          Text(
                            movieModel!.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
