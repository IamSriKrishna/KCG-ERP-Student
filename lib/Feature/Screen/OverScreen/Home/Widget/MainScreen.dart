import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Constrains/Component.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/Additional/PostCard.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/Additional/TopMainScreen.dart';
import 'package:kcgerp/Feature/Screen/Search/Search.dart';
import 'package:kcgerp/Feature/Service/postService.dart';
import 'package:kcgerp/Model/post.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class MainScreen extends StatefulWidget {
  final void Function() icon1OnTap;

  const MainScreen({super.key, required this.icon1OnTap});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey search = GlobalKey();
  final GlobalKey message = GlobalKey();
  ScrollController _scrollController = ScrollController();
  List<Post>? fetchpost;
  final AddPostService _postService = AddPostService();
  bool _isMounted = false;
  bool _show = true;
  @override
  void initState() {
    super.initState();
    _isMounted = true;
    checkShowcaseStatus();
    fetchAllProducts();
  }

  Future<void> checkShowcaseStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final showcaseShown = prefs.getBool('showcaseShown2') ?? false;

    if (!showcaseShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([search, message]);
      });

      await prefs.setBool('showcaseShown2', true);
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  fetchAllProducts() async {
    try {
      fetchpost = await _postService.DisplayAllForm(context: context);
      if (_isMounted) {
        setState(() {});
      }
    } catch (e) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(
              S.current.warning,
              style: GoogleFonts.merriweather(),
            ),
            content: Text(
              S.current.wanttoexitcampuslink,
              style: GoogleFonts.merriweather(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  S.current.no,
                  style: GoogleFonts.merriweather(),
                ),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  S.current.yes,
                  style: GoogleFonts.merriweather(),
                ),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              leadingWidth: MediaQuery.of(context).size.width *0.55,
              backgroundColor:
                  theme.getDarkTheme ? themeColor.darkTheme : themeColor.themeColor,
              leading: Row(
                children: [
                  InkWell(
                    onTap: () {
                      showPopupMenu(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 10),
                      child: Icon(Icons.more_vert),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                  _scrollController.animateTo(
                    0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                    },
                    child: RobotoBoldFont(
                      size: 18,
                      text: S.current.myClass,
                      textColor: theme.getDarkTheme
                          ? themeColor.backgroundColor
                          : themeColor.appBarColor,
                    ),
                  ),
                ],
              ),
              elevation: 10,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SearchScreen.route);
                  },
                  child: ShowCaseView(
                    globalKey: search,
                    title: 'Search Screen',
                    description: "Find College Students Easily",
                    child: Icon(
                      Icons.search,
                      color: theme.getDarkTheme
                          ? themeColor.themeColor
                          : themeColor.appBarColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.icon1OnTap,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, bottom: 19, top: 17, right: 15),
                    child: ShowCaseView(
                        globalKey: message,
                        title: 'Messenger',
                        description:
                            "Stay connected anytime, anywhere with our Messenger. Chat, share, and connect effortlessly with classmates.",
                        child: Image.asset('asset/message.png')),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: TopMainScreen(context: context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final reversedIndex = fetchpost!.length - 1 - index;
                  final productData = fetchpost![reversedIndex];
                  if (fetchpost == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return _show?PostCard(
                    title: productData.title,
                    dp: productData.dp,
                    images: productData.image_url,
                    description: productData.description,
                    likes: productData.likes,
                    link: productData.link,
                    name: productData.name,
                  ):Center(
                    child: Text('No Post From ${student.year}'),
                  );
                },
                childCount:_show? fetchpost?.length ?? 0:1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the PopupMenu
  void showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(-5, 1, 0, 0),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      items: [
        PopupMenuItem(
          value: 'my class',
          onTap: () {
            setState(() {
              _show = false;
            });
            //Navigator.pop(context);
          },
          child: Text('My Class'),
        ),
        PopupMenuItem(
          value: 'all',
          onTap: () {
              setState(() {
                _show = true;
              });
              //Navigator.pop(context);
            },
          child: Text('All'),
        ),
      ]
    );
  }
}