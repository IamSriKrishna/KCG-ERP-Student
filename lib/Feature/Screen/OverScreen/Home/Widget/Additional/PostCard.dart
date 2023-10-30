
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/Additional/likeAnimation.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4.5,horizontal: 5),
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
                        student.dp,
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
                              student.name.toUpperCase(),
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
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: Image.network(
                        'https://www.kcgtech.in/assets/img/intro-bg.jpg',
                        fit: BoxFit.cover,
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
                  IconButton(
                      icon: const Icon(
                        Icons.send,
                      ),
                      onPressed: () {}),
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
                          '${10}M likes',
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
                              text: '',
                              style: GoogleFonts.merriweather(
                            color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.darkTheme
                          ),
                            ),
                            TextSpan(
                              text: 'KCG COllege Of technology',
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'View all 1M comments',
                          style: GoogleFonts.merriweather(
                            color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.darkTheme,
                            fontSize: 16
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
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