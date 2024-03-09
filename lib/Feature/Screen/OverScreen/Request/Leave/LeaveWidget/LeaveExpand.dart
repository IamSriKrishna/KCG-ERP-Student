import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/LeaveAppbar.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/LeaveCustomField.dart';
import 'package:kcgerp/Feature/Service/FacultyData.dart';
import 'package:kcgerp/Feature/Service/FormService.dart';
import 'package:kcgerp/Feature/Service/NotificationService.dart';
import 'package:kcgerp/Model/faculty.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class LeaveExpand extends StatefulWidget {
  static const route = '/LeaveExpand';
  const LeaveExpand({super.key});

  @override
  State<LeaveExpand> createState() => _LeaveExpandState();
}

class _LeaveExpandState extends State<LeaveExpand> {
  FormService _formService = FormService();
  TextEditingController _reason = TextEditingController();

  List<faculty>? fetchfaculty;
  FacultyService _facultyService = FacultyService();
  final NotificationService _fcmNotification = NotificationService();
  @override
  void initState() {
    retreive();
    super.initState();
  }

  void retreive() async {
    fetchfaculty = await _facultyService.DisplayAllFaculty(context: context);
    //print(fetchfaculty);
    setState(() {});
  }

  void UploadForm(
      String studentid,
      String rollno,
      String name,
      String department,
      String image,
      String year,
      String Studentclass,
      String reason,
      int no_of_days,
      String from,
      String to,
      DateTime createdAt,
      int spent,
      String fcmToken) {
    for (int i = 0; i < fetchfaculty!.length; i++) {
      _fcmNotification.sendNotifications(
          context: context,
          toAllFaculty: [fetchfaculty![i].fcmtoken],
          body: "Form Request Recieved from ${name}");
    }
    _formService.UploadForm(
        studentid: studentid,
        context: context,
        createdAt: createdAt,
        rollno: rollno,
        fcmtoken: fcmToken,
        name: name,
        department: department,
        image: image,
        year: year,
        formtype: 'Leave',
        Studentclass: Studentclass,
        reason: reason,
        no_of_days: no_of_days,
        from: from,
        to: to,
        spent: spent);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final startDay = args['from'] as DateTime;
    final endDay = args['to'] as DateTime;
    final days = args['days'];
    final spent = args['spent'];
    final student = Provider.of<StudentProvider>(context).user;
    return WillPopScope(
      onWillPop: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Warning!', style: GoogleFonts.merriweather()),
            content: Text(S.current.yousurewanttoexitthispage,
                style: GoogleFonts.merriweather()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.merriweather(),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, OverScreen.route, ((route) => false));
                  },
                  child: Text(
                    'Proceed',
                    style: GoogleFonts.merriweather(),
                  )),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: LeaveAppBarTwo(context: context, text: S.current.leave),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            LeaveCustomField(label: "Name", hint: student.name.toUpperCase()),
            LeaveCustomField(
                label: "Roll Number", hint: student.rollno.toUpperCase()),
            LeaveCustomField(
                label: "Department", hint: student.department.toUpperCase()),
            LeaveCustomField(
                label: S.current.from,
                hint: DateFormat('yyyy-MM-dd').format(startDay)),
            LeaveCustomField(
                label: S.current.to,
                hint: DateFormat('yyyy-MM-dd').format(endDay)),
            LeaveCustomField(
                label: days == 1 ? "No of Day" : "No of Days",
                hint: days == 1 ? '${days} Day' : '${days} Days'),
            LeaveCustomFieldTwo(
              label: S.current.reason,
              hint: 'Enter Your Reason',
              reason: _reason,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: themeColor.appThemeColor),
                  onPressed: () {
                    UploadForm(
                        student.id,
                        student.rollno,
                        student.name,
                        student.department,
                        student.dp,
                        student.year,
                        '5-B',
                        _reason.text,
                        days,
                        DateFormat('yyyy-MM-dd').format(startDay).toString(),
                        DateFormat('yyyy-MM-dd').format(endDay).toString(),
                        DateTime.now(),
                        spent,
                        student.fcmtoken);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'SUBMIT',
                      style: GoogleFonts.merriweather(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
