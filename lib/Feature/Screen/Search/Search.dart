import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/3rdUserProfile/ThirdUserProfile.dart';
import 'package:kcgerp/Feature/Service/Authservice.dart';
import 'package:kcgerp/Feature/Service/NotificationService.dart';
import 'package:kcgerp/Model/Student.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
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
  NotificationService _notificationService = NotificationService();
  Future<void> _search() async {
    try {
      final student = Provider.of<StudentProvider>(context,listen: false).user;
      List<Student> searchedStudents =
          await authService.searchStudentsByName(_searchController.text,student.id);
      setState(() {
        _searchedStudents = searchedStudents;
      });
    } catch (e) {
      //print('Error fetching student data: $e');
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
    final student = Provider.of<StudentProvider>(context).user;
    if (_searchedStudents.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                _notificationService.sendNotifications(
                    context: context, 
                    toAllFaculty: [_searchedStudents[index].fcmtoken],
                    body: '${student.name} Viewed Your Profile!'
                  );
                Get.to(()=>
                  ThirdUserProfile(
                    name: _searchedStudents[index].name, 
                    department: _searchedStudents[index].department, 
                    rollno: _searchedStudents[index].rollno, 
                    dp: _searchedStudents[index].dp, 
                    certified: _searchedStudents[index].certified,
                    id: _searchedStudents[index].id,
                    fcmtoken: _searchedStudents[index].fcmtoken,
                    current_student_id:student.id
                    )
                  );

                  
                
                
              },
              child: ListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: _searchedStudents[index].dp,
                    width: MediaQuery.of(context).size.width * 0.135,
                    height: MediaQuery.of(context).size.height * 0.065,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: 
                    (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color:theme.getDarkTheme?themeColor.themeColor: themeColor.darkTheme,
                      ),
                    ),
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
                'No students found with the\nprovided name',
                textAlign: TextAlign.center,
                maxLines: 2,
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
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, MediaQuery.of(context).size.width * 0.108), 
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
            )
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
          // SliverToBoxAdapter(
          //   child: ,
          // ),
          _buildStudentList(),
        ],
      ),
    );
  }
}
