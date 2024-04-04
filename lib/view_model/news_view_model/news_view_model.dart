


import 'package:newsapp/models/catergories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';
import 'package:newsapp/repository/news_repository/news_repository.dart';

class NewViewModel {

  final _rep = NewsRepository();


  Future<NewsChannelsHeadlinesModel> fetachNewsChannelHeadlines(String channelName) async {
    final responce = await _rep.fetachNewsChannelHeadlines(channelName);
    return responce;
  }

  Future<CatergoriesNewsModel> fetchCategoriesNewsApi(String channelName) async {
    final responce = await _rep.fetchCategoriesNewsApi(channelName);
    return responce;
  }


}