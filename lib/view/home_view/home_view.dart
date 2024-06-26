

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/catergories_news_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';
import 'package:newsapp/view/categories_view/categories_view.dart';
import 'package:newsapp/view/news_detial_view/news_detail_view.dart';
import 'package:newsapp/view_model/news_view_model/news_view_model.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();

  static const spinkit2 = SpinKitFadingCircle(
    color: Colors.amber,
    size: 50,
  );
}

enum FilterList {bbcNews , aryNews , aljazeera , independent , reuters , cnn}

class _HomeViewState extends State<HomeView> {

  FilterList? selectedMenu;

  final NewViewModel newViewModel = NewViewModel();
  final dateformat = DateFormat('MMM dd, yyyy');

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesView()));
          },
          icon: Image.asset('images/category_icon.png',width: 24,height: 24,),
        ),
        title: Text('News',style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterList>(
            onSelected: (FilterList item){
              if(FilterList.bbcNews.name == item.name){
                name == 'bbc-news';
              }
              if(FilterList.aryNews.name == item.name){
                name = 'ary-news';
              }
              if(FilterList.cnn.name == item.name){
                name = 'cnn';
              }
              if(FilterList.aljazeera.name == item.name){
                name = 'al-jazeera-english';
              }

              setState(() {
                selectedMenu = item;
              });
            },
            icon: Icon(Icons.more_vert,color: Colors.black,),
            initialValue: selectedMenu,
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                PopupMenuItem(
                  value: FilterList.bbcNews,
                    child: Text("BBC News")
                ),
                PopupMenuItem(
                  value: FilterList.aryNews,
                    child: Text("Ary News")
                ),
                PopupMenuItem(
                  value: FilterList.aljazeera,
                    child: Text("Al Jazeera")
                ),
                PopupMenuItem(
                  value: FilterList.cnn,
                    child: Text("CNN News")
                ),
              ]
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newViewModel.fetachNewsChannelHeadlines(name),
              builder: (context , snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context , index) {

                    DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailView(
                              newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                              newsTitle: snapshot.data!.articles![index].title.toString(),
                              newsDate: dateformat.format(dateTime),
                              auther: snapshot.data!.articles![index].author.toString(),
                              descripition: snapshot.data!.articles![index].description.toString(),
                              content: snapshot.data!.articles![index].content.toString(),
                              source: snapshot.data!.articles![index].source!.name.toString())));
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              //////// background image
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.02
                                  ),
                                height: height * 0.7,
                                  width: width * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context , url) => Container(child: HomeView.spinkit2,),
                                      errorWidget: (context , url , error) => Icon(Icons.error_outline, color: Colors.red,),
                                    ),
                                  )
                              ),

                              ///// card
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15),
                                    height: height * 0.18,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        /////// news title ///////
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot.data!.articles![index].title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 17, fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        ),
                                        Spacer(),

                                        ////////  news source and date time
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index].source!.name.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13, fontWeight: FontWeight.w600,
                                                  color: Colors.blue
                                                ),
                                              ),
                                              Text(dateformat.format(dateTime) ,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                });
              },
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<CatergoriesNewsModel>(
                future: newViewModel.fetchCategoriesNewsApi('General'),
                builder: (context , snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: Text('....')
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context , index) {
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return snapshot.data!.articles![index].urlToImage == null ? SizedBox() : InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailView(
                                newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                newsTitle: snapshot.data!.articles![index].title.toString(),
                                newsDate: dateformat.format(dateTime),
                                auther: snapshot.data!.articles![index].author.toString(),
                                descripition: snapshot.data!.articles![index].description.toString(),
                                content: snapshot.data!.articles![index].content.toString(),
                                source: snapshot.data!.articles![index].source!.name.toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:  15.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    height: height * .18,
                                    width: width * 0.3,

                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context , url) => Container(child: Center(
                                      child: SpinKitCircle(
                                        size: 50,
                                        color: Colors.blue,
                                      ),
                                    ),),
                                    errorWidget: (context , url , error) => Icon(Icons.error_outline, color: Colors.red,),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index].title.toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index].source!.name.toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                dateformat.format(dateTime),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
