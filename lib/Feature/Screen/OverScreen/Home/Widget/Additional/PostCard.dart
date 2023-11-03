
// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/Additional/likeAnimation.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final String dp;
  final String name;
  final String title;
  final String description;
  final List<String> likes;
  final List<String> images;
  final String link;
  const PostCard({
    Key? key,
    required this.title,
    required this.dp,
    required this.images,
    required this.description,
    required this.likes,
    required this.link,
    required this.name
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:0.5,horizontal: 5),
      child: Card(
        elevation: 10,
        color: theme.getDarkTheme?Color.fromARGB(255, 228, 222, 222).withOpacity(0.1):Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: theme.getDarkTheme?Color.fromARGB(255, 228, 222, 222).withOpacity(0.1):Color.fromARGB(255, 255, 255, 255),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            children: [
              // HEADER SECTION OF THE POST
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ).copyWith(right: 0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        widget.dp,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.name.toUpperCase(),
                              style: GoogleFonts.merriweather(
                                color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.darkTheme,
                                fontSize: 12
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // IMAGE SECTION OF THE POST
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    isLikeAnimating = !isLikeAnimating;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.32,
                      width: double.infinity,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.32,
                        width: double.infinity,
                        child: CarouselSlider(
                          items: widget.images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => PinchZoom(
                                  maxScale: 3,
                                  child: Image.network(
                                    i,
                                    fit: BoxFit.contain,
                                    height:  MediaQuery.of(context).size.height * 0.32,
                                    width: double.infinity,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isLikeAnimating ? 1 : 0,
                      child: LikeAnimation(
                        isAnimating: isLikeAnimating,
                        duration: const Duration(
                          milliseconds: 400,
                        ),
                        onEnd: () {
                          setState(() {
                            isLikeAnimating = false;
                          });
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // LIKE, COMMENT SECTION OF THE POST
              Row(
                children: <Widget>[
                  LikeAnimation(
                    isAnimating: isLikeAnimating,
                    smallLike: true,
                    child: IconButton(
                      icon: isLikeAnimating
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                      onPressed: () {
                        isLikeAnimating = !isLikeAnimating;
                      }
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.comment_outlined,
                    ),
                    onPressed: () {}
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        icon: const Icon(Icons.bookmark_border), onPressed: () {}),
                  ))
                ],
              ),
              //DESCRIPTION AND NUMBER OF COMMENTS
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w800),
                        child: Text(
                          '0 Likes',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.merriweather(
                            color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.darkTheme
                          ),
                          children: [
                            TextSpan(
                              text: 'Title:${widget.title}',
                              style: GoogleFonts.merriweather(
                            color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.darkTheme
                          ),
                            ),
                            TextSpan(
                              text: '\nDescription:${widget.description}',
                              style: GoogleFonts.merriweather(
                            color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.darkTheme
                          ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.link!='null'?Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Link:',
                            style: GoogleFonts.merriweather(
                              color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.darkTheme,
                              // fontSize: 14
                            ),
                          ),
                        ),
                        InkWell(child: Text(widget.link))
                      ],
                    ):SizedBox(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(DateTime.now()),
                        style:  GoogleFonts.merriweather(
                            color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.darkTheme,
                            fontSize: 14
                          ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}