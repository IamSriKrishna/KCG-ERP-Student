
// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/Additional/likeAnimation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class PostCard extends StatefulWidget {
  final String dp;
  final String name;
  final String title;
  final String description;
  final List<String> likes;
  final List<String> images;
  final String link;
  final DateTime createdAt;
  const PostCard({
    Key? key,
    required this.title,
    required this.dp,
    required this.images,
    required this.description,
    required this.likes,
    required this.link,
    required this.name,
    required this.createdAt
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
    Future<void> link(Uri _url) async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
                width: double.infinity,
                child: ZoomOverlay(
                  modalBarrierColor: Colors.black12, // Optional
                  minScale: 0.5, // Optional
                  maxScale: 3.0, // Optional
                  animationCurve: Curves.fastOutSlowIn, // Defaults to fastOutSlowIn which mimics IOS instagram behavior
                  animationDuration: Duration(milliseconds: 300), // Defaults to 100 Milliseconds. Recommended duration is 300 milliseconds for Curves.fastOutSlowIn
                  twoTouchOnly: true, // Defaults to false
                  onScaleStart: () {}, // optional VoidCallback
                  onScaleStop: () {}, // optional VoidCallback
                  child: CachedNetworkImage(
                      imageUrl: widget.images[0],
                      fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              // LIKE, COMMENT SECTION OF THE POST
              // Row(
              //   children: <Widget>[
              //     LikeAnimation(
              //       isAnimating: isLikeAnimating,
              //       smallLike: true,
              //       child: IconButton(
              //         icon: isLikeAnimating
              //             ? const Icon(
              //                 Icons.favorite,
              //                 color: Colors.red,
              //               )
              //             : const Icon(
              //                 Icons.favorite_border,
              //               ),
              //         onPressed: () {
              //           isLikeAnimating = !isLikeAnimating;
              //         }
              //       ),
              //     ),
              //     IconButton(
              //       icon: const Icon(
              //         Icons.comment_outlined,
              //       ),
              //       onPressed: () {}
              //     ),
              //     Expanded(
              //         child: Align(
              //       alignment: Alignment.bottomRight,
              //       child: IconButton(
              //           icon: const Icon(Icons.bookmark_border), onPressed: () {}),
              //     ))
              //   ],
              // ),
              //DESCRIPTION AND NUMBER OF COMMENTS
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // DefaultTextStyle(
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .titleSmall!
                    //         .copyWith(fontWeight: FontWeight.w800),
                    //     child: Text(
                    //       '0 Likes',
                    //       style: Theme.of(context).textTheme.bodyMedium,
                    //     )),
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
                    widget.link!='null'?Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'Link:',
                              style: GoogleFonts.merriweather(
                                color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.darkTheme,
                                fontSize: 14
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top:2.0),
                              child: InkWell(
                                onTap: () {
                                  link(Uri.parse(widget.link));
                                },
                                child: Text(
                                  widget.link,
                                  maxLines: 3,
                                style: GoogleFonts.merriweather(
                                  color:Colors.blue,
                                  fontSize: 14,
                                  textBaseline: TextBaseline.alphabetic,
                                  decoration: TextDecoration.underline
                                ),)),
                            ),
                          )
                        ],
                      ),
                    ):SizedBox(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(widget.createdAt),
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