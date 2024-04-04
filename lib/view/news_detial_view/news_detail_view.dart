import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailView extends StatefulWidget {
  final newsImage, newsTitle, newsDate, auther, descripition, content, source;
  const NewsDetailView({
    super.key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.auther,
    required this.descripition,
    required this.content,
    required this.source,
  });

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
                placeholder: (context , url) => Center(child: CircularProgressIndicator(color: Colors.blue,)),
              ),
            ),
          ),

          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: EdgeInsets.only(top: 20,right: 20,left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
              ),
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.source,style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600
                    )),
                    Text(widget.newsDate,style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                SizedBox(height: height * 0.03,),
                Text(widget.descripition,style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
