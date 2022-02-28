import 'dart:developer';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:move/views/in_app_bro.dart';

class DescriptionScreen extends StatefulWidget {
  int id;

  num vote_average;

  String title;

  String poster_path;

  String release_date;

  String backdrop_path;

  String overview;

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();

  DescriptionScreen({
    required this.id,
    required this.vote_average,
    required this.title,
    required this.poster_path,
    required this.release_date,
    required this.backdrop_path,
    required this.overview,
  });
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.network(
          widget.poster_path,
          fit: BoxFit.fill,
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaY: 4.5, sigmaX: 4.5),
          child: Container(
            color: Colors.redAccent.withOpacity(0.2),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: const Text(
                        "Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    front: Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(widget.poster_path),fit: BoxFit.fill
                          )

                      ),

                    ),
                    back: Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(widget.backdrop_path),fit: BoxFit.fill)),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 80,
                        child: Text(widget.title,
                          style: const TextStyle(
                          fontSize: 19,color: Colors.red,fontWeight: FontWeight.bold,backgroundColor: Colors.white
                        ),
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: Text("${widget.vote_average}",
                          style: const TextStyle(
                              fontSize: 19,color: Colors.red,fontWeight: FontWeight.w900,backgroundColor: Colors.white
                          ),
                        ),
                      ),

                    ],
                  ),
                  Text(widget.overview,
                    style: const TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),

                    child: MaterialButton(

                      child: const Text("Watch Now",style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,
                      ),),
                        onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          BuildContext context) {
                        return MyAppApp(widget.title);
                      }
                      )
                      );
                    }),
                  ),
                ],
              ),

            ),
          ),
        )
      ]),

    );
  }
}
