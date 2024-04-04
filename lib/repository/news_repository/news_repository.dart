import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/catergories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';


class NewsRepository {



  //////// channel headlines method ////
  Future<NewsChannelsHeadlinesModel> fetachNewsChannelHeadlines(String channelName) async {

    String url = 'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=d7d27942a8de49afb3bbdf2c2b178ab9';
    final responce = await http.get(Uri.parse(url));

    if(responce.statusCode == 200){
      final body = jsonDecode(responce.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');

  }

  /////// categories news method ////////
  Future<CatergoriesNewsModel> fetchCategoriesNewsApi(String category) async {

    String url =  'https://newsapi.org/v2/everything?q=$category&apiKey=d7d27942a8de49afb3bbdf2c2b178ab9';
    final responce = await http.get(Uri.parse(url));

    if(responce.statusCode == 200){
      final body = jsonDecode(responce.body);
      return CatergoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');

  }


}