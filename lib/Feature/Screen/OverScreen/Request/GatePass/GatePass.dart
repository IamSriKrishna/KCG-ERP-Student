
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Service/Credit.dart';
import 'package:kcgerp/Feature/Service/FacultyData.dart';
import 'package:kcgerp/Feature/Service/FormService.dart';
import 'package:kcgerp/Feature/Service/NotificationService.dart';
import 'package:kcgerp/Model/faculty.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/GatePass/GatePassHistory.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Widget/ApprovalButton.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class GatePassScreen extends StatefulWidget {
  static const route = '/GatePassScreen';
  final String locale;
  GatePassScreen({required this.locale});
  @override
  State<GatePassScreen> createState() => _GatePassScreenState();
}

class _GatePassScreenState extends State<GatePassScreen> {
  
  final TextEditingController message = TextEditingController();
  DatePickerController datePick = DatePickerController();
  TimeOfDay selectedFrom = TimeOfDay.now();
  TimeOfDay selectedTo = TimeOfDay.now();
  StudentCredit studentCredit = StudentCredit();
  FormService _formService = FormService();
  List<faculty>? fetchfaculty;
  FacultyService _facultyService = FacultyService();
  final NotificationService _fcmNotification = NotificationService();
  @override
  void initState() {
    retreive();
    super.initState();
  }
  void retreive()async{
    fetchfaculty = await  _facultyService.DisplayAllFaculty(context: context);
    //print(fetchfaculty);
    setState(() {
      
    });
  }
  void leave({
    required String rollno,
    required String name,
    required String department,
    required String image,
    required String year,
    required String Studentclass,
    required String reason,
    required String studentid,
    required int spent,
    required String fcmtoken,
    required String from,
    required String to,
  }){
    for(int i =0;i<fetchfaculty!.length;i++){
      _fcmNotification.sendNotifications(
        context: context, 
        toAllFaculty: [fetchfaculty![i].fcmtoken],
        body:"Form Request Recieved from ${name}"
      );
    }
    _formService.UploadForm(
      context: context, 
      rollno: rollno, 
      name: name, 
      department: department, 
      image: image, 
      year: year, 
      fcmtoken:fcmtoken,
      formtype: 'Gate Pass', 
      Studentclass: Studentclass, 
      reason: reason, 
      no_of_days: 0, 
      from: from, 
      to: to, 
      createdAt: DateTime.now(), 
      studentid: studentid, 
      spent: spent
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final credit = args['credit'];
    final theme = Provider.of<DarkThemeProvider>(context);
    final student = Provider.of<StudentProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(GatePassHistory.route);
            },
            icon: Icon(Icons.info),
          )
        ],
        backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.backgroundColor,
        scrolledUnderElevation: 15,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          }, 
          child: Icon(
            Icons.arrow_back_ios,
            color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
          )
        ),
        //Request Title
        title: Text(
          S.current.gatePass,
          style: GoogleFonts.merriweather(
            color: theme.getDarkTheme?Colors.white:themeColor.appBarColor
          ),
        )
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top:15.0,left: 5),
            child: Text(
              S.current.today,
              style: GoogleFonts.merriweather(
                color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
                fontSize: 25
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5,left: 15),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              activeDates: [DateTime.now()],
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: themeColor.appThemeColor2,
              monthTextStyle: GoogleFonts.merriweather(
                color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
              ),
              dateTextStyle: GoogleFonts.merriweather(
                color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
              ),
              dayTextStyle: GoogleFonts.merriweather(
                color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
              ),
            )
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            thickness: 2,
          ),
          //From-To
          Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: selectedFrom,
                  initialEntryMode: TimePickerEntryMode.dialOnly);
              if (timeOfDay != null) {
                setState(() {
                  selectedFrom = timeOfDay;
                });
              }
            },
            child: SizedBox(
              height: double.infinity,
              width: MediaQuery.of(context).size.width * 0.38,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.from,
                      style: GoogleFonts.merriweather(
                        color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                        fontSize: 18
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm,
                          color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RobotoBoldFont(
                            text:
                                '${selectedFrom.hour}:${selectedFrom.minute}',
                            size: 25,
                            textColor: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                          ),
                        ),
                        selectedFrom.hour >= 12
                            ?
                            Text(
                              'Pm',
                              style: GoogleFonts.merriweather(
                                color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                              ),
                            )
                            : Text(
                              'Am',
                              style: GoogleFonts.merriweather(
                                color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                              ),
                            )
                      ],
                    ),
                    const Divider(
                      indent: 25,
                      endIndent: 25,
                      thickness: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Image.asset(assetImage.requestForm2)),
          GestureDetector(
            onTap: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: selectedTo,
                  initialEntryMode: TimePickerEntryMode.dialOnly);
              if (timeOfDay != null) {
                setState(() {
                  selectedTo = timeOfDay;
                });
              }
            },
            child: SizedBox(
              height: double.infinity,
              width: MediaQuery.of(context).size.width * 0.38,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.to,
                      style: GoogleFonts.merriweather(
                        color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                        fontSize: 18
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm,
                          color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RobotoBoldFont(
                            text:
                                '${selectedTo.hour}:${selectedTo.minute}',
                            size: 25,
                            textColor: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                          ),
                        ),
                        selectedTo.hour >= 12
                        ?
                        Text(
                          'Pm',
                          style: GoogleFonts.merriweather(
                            color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                          ),
                        )
                        : Text(
                          'Am',
                          style: GoogleFonts.merriweather(
                            color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      indent: 25,
                      endIndent: 25,
                      thickness: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
          //Send Request message
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
                ),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10
                ),
                child: TextField(
                  style:GoogleFonts.merriweather(
                    fontWeight: FontWeight.w400,
                    fontSize: 18
                  ),
                  minLines: 15,
                  maxLines: 15,
                  controller: message,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color:theme.getDarkTheme?Colors.white:Colors.black
                    ),
                    hintText: S.current.reason,
                    border: InputBorder.none
                  ),
                ),
              ),
            ),
          ),
          ApprovalButton(
            message: message,
            onTap: () async{
              if(student.credit <= 0){
                //print('Insuffient Balence');
                studentCredit.updateStudentCreditToZero(student.id, 0);
              }
              else{
                leave(
                  rollno: student.rollno, 
                  name: student.name, 
                  department: student.department, 
                  image: student.dp, 
                  fcmtoken:student.fcmtoken,
                  year: student.year, 
                  Studentclass: 'NULL', 
                  reason: message.text, 
                  studentid: student.id, 
                  spent: credit, 
                  from: '${selectedFrom.hour}:${selectedFrom.minute}', 
                  to: '${selectedTo.hour}:${selectedTo.minute}'
                );
                studentCredit.updateStudentCredit(student.id, credit);
              }
            
            },
          )
        ],
      ),
    );
  }
}

