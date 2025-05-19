import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sinema_app/const/loading.dart';
import 'package:sinema_app/const/url.dart';
import 'package:sinema_app/model/movie_model.dart';

class ImageFull extends StatefulWidget {
  const ImageFull({super.key, required this.id});
  final String id;

  @override
  State<ImageFull> createState() => _ImageFullState();
}

class _ImageFullState extends State<ImageFull> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          movieModel == null
              ? Center(child: LoadingWidget())
              : Center(
                child: Hero(
                  tag: 'imageHero${movieModel!.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: Image.network(
                      movieModel!.image_url,
                      fit: BoxFit.contain,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
    );
  }
}
