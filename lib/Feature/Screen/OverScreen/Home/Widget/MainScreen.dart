import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/Additional/PostCard.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/Additional/TopMainScreen.dart';
import 'package:kcgerp/Feature/Service/postService.dart';
import 'package:kcgerp/Model/post.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/Additional/Loader.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final void Function() icon1OnTap;
  const MainScreen({super.key,required this.icon1OnTap});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Post>? fetchpost;

  final AddPostService _postService = AddPostService();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    fetchpost = await _postService.DisplayAllForm(context:context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return fetchpost==null?Loader() :Scaffold(
      appBar: AppBar(
        backgroundColor:theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
        title: Text(
          S.current.myClass,
          style: GoogleFonts.merriweather(
            color:theme.getDarkTheme?themeColor.backgroundColor: themeColor.appBarColor
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: TopMainScreen(context: context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (fetchpost!.length ==0) {
                  // Handle the case when post is null, e.g., show a loading indicator or an error message.
                  return Center(child: CircularProgressIndicator()); // Replace with your preferred loading widget.
                }
                
                final reversedIndex = fetchpost!.length - 1 - index;
                final productData = fetchpost![reversedIndex];
                return PostCard(
                  title: productData.title, 
                  dp: productData.dp, 
                  images: productData.image_url,
                  description: productData.description, 
                  likes: productData.likes, 
                  link: productData.link, 
                  name: productData.name
                ); // Replace with your logic for rendering a Post card.
              },
              childCount: fetchpost?.length ?? 0, // Provide a default count of 0 when post is null.
              
            ),
          ),
        ],
      ),
    );
  }
}