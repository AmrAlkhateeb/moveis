import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:move/controller/getdata.dart';
import 'package:move/controller/getpopular.dart';
import 'package:move/models/constaint.dart';
import 'package:move/views/descriptionscreen.dart';

class HomeScreen extends StatelessWidget {

  final getdata = ChangeNotifierProvider<GetdataFromApi>((ref)=>GetdataFromApi());
  final getdatapopular = ChangeNotifierProvider<getpopular>((ref)=>getpopular());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
          ),
        ],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Netflix",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Consumer(
            builder: (context, watch, child) {
              final veiwdata = watch(getdata);
              if (veiwdata.Loading== true)
              {
                return Center(child: CircularProgressIndicator());
              }
              if (veiwdata.Error== true)
              {
                return Center(child: Text("NO INternet"));
              }
              else{ return CarouselSlider.builder(
                  itemCount: veiwdata.listdatamodel.length,
                  itemBuilder: (context, index, realIndex) {
                    return GridTile(
                      child: Image.network(
                        image_url + veiwdata.listdatamodel[index].poster_path,
                        fit: BoxFit.fill,
                      ),
                      footer: Container(
                          height: MediaQuery.of(context).size.height / 22,
                          color: Colors.white.withOpacity(0.5),
                          alignment: Alignment.center,
                          child: Text(
                            veiwdata.listdatamodel[index].title,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w900),
                          )),
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 3,
                    aspectRatio: 1.5,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ));}

            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          Expanded(
            child: Consumer(builder: (context, watch, child)
            {
              final veiwpopular = watch(getdatapopular);
              if (veiwpopular.Loading== true)
              {
                return Center(child: CircularProgressIndicator());
              }
              if (veiwpopular.Error== true)
              {
                return Center(child: Text("NO INternet"));
              }
              else
                {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: veiwpopular.listdatamodel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)
                          {
                            return DescriptionScreen(
                              id: veiwpopular.listdatamodel[index].id,
                              vote_average: veiwpopular.listdatamodel[index].vote_average,
                              title: "${veiwpopular.listdatamodel[index].title}",
                              poster_path: "${image_url+veiwpopular.listdatamodel[index].poster_path}",
                              release_date: "${veiwpopular.listdatamodel[index].release_date}",
                              backdrop_path: "${image_url+veiwpopular.listdatamodel[index].backdrop_path}",
                              overview: veiwpopular.listdatamodel[index].overview,
                            );
                          }
                          )
                          );
                        },
                        child: Card(
                          color: primarycolor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.network(
                                  image_url +
                                      veiwpopular.listdatamodel[index].poster_path,
                                  fit: BoxFit.cover,
                                ),

                                Card(
                                  color: Colors.black,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      veiwpopular.listdatamodel[index].title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.bold,color: Colors.white ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                  );
                }

            }),
          ),
        ],
      ),
    );
  }
}
