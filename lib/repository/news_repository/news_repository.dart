import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/news_channel_headlines_model.dart';


class NewsRepository {

  Future<NewsChannelsHeadlinesModel> fetachNewsChannelHeadlines() async {

    String url = ' https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d7d27942a8de49afb3bbdf2c2b178ab9';

    final responce = await http.get(Uri.parse(url));

    if(responce.statusCode == 200){
      final body = jsonDecode(responce.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');

  }

}