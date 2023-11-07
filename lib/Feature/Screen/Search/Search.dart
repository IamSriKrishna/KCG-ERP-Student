import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/Messenger/ChatScreen.dart';
import 'package:kcgerp/Feature/Service/Authservice.dart';
import 'package:kcgerp/Model/Student.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const route = '/SearchScreen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  AuthService authService = AuthService();
  List<Student> _searchedStudents = [];

  Future<void> _search() async {
    try {
      List<Student> searchedStudents =
          await authService.searchStudentsByName(_searchController.text);
      setState(() {
        _searchedStudents = searchedStudents;
      });
    } catch (e) {
      print('Error fetching student data: $e');
    }
  }

  @override
  void initState() {
    _searchController.addListener(_onSearchTextChanged);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    _searchController.addListener(_onSearchTextChanged);
    super.didChangeDependencies();
  }
  void _onSearchTextChanged() {
    _search();
    setState(() {
      
    });
  }

  Widget _buildStudentList() {
    final theme = Provider.of<DarkThemeProvider>(context);
    if (_searchedStudents.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  ChatScreen.route,
                  (route)=>false,
                  arguments: {
                    'name':_searchedStudents[index].name,
                    'dp':_searchedStudents[index].dp,
                    'registerno':_searchedStudents[index].rollno,
                    'dep':_searchedStudents[index].department
                  }
                );
              },
              child: ListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: _searchedStudents[index].dp,
                    width: MediaQuery.of(context).size.width * 0.135,
                    height: MediaQuery.of(context).size.height * 0.065,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      _searchedStudents[index].name,
                      style: GoogleFonts.merriweather(),
                    ),
                    _searchedStudents[index].certified==true?
                    Padding(
                      padding: const EdgeInsets.only(left:2.0),
                      child: Image.asset(
                        'asset/tick.png',
                        height: MediaQuery.of(context).size.height * 0.019,
                        color: theme.getDarkTheme?themeColor.appThemeColor:Colors.black,
                      ),
                    ):
                    Text('')
                  ],
                ),
                subtitle: Text(
                  '${_searchedStudents[index].rollno}',
                  style: GoogleFonts.merriweather(),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
          childCount: _searchedStudents.length,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Lottie.asset('asset/lottie/null.json'),
              ),
              Text(
                'No students found with the provided name',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  fontSize: 20
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: theme.getDarkTheme
                    ? themeColor.backgroundColor
                    : themeColor.appBarColor,
              ),
            ),
            floating: true,
            backgroundColor: theme.getDarkTheme
                ? themeColor.darkTheme
                : themeColor.themeColor,
            title: RobotoBoldFont(
              text: 'Search',
              textColor: theme.getDarkTheme
                  ? themeColor.backgroundColor
                  : themeColor.appBarColor,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.108,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.5),
                  color: Color.fromARGB(255, 207, 207, 207).withOpacity(0.5),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search,
                        color: theme.getDarkTheme
                            ? themeColor.backgroundColor
                            : themeColor.appBarColor),
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
          ),
          _buildStudentList(),
        ],
      ),
    );
  }
}
