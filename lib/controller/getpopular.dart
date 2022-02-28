import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/models/movi.dart';
import 'package:http/http.dart' as http;

class getpopular extends ChangeNotifier
{
  bool Error=true;
  bool Loading=true;

  List<Movie>listdatamodel= [];

  getpopular()
  {
    fetchdata();
  }

  Future<void> fetchdata ()async
  {
    listdatamodel=[];
    listdatamodel.clear();
    try {
      String apikey = "caf50c3f7c7a940de782de88f08531c5";
      var url = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=$apikey&language=en-US");
      var resbonse=await http.get(url);
      var resbonsebody=jsonDecode(resbonse.body)["results"];
      for (var i in resbonsebody)
      {
        listdatamodel.add(Movie.fromMap(i));
      }
      Error = false;
      Loading = false;
    }
    catch(e)
    {
      Error = true;
      Loading = false;
      print(e);
    }
    notifyListeners();

  }


}