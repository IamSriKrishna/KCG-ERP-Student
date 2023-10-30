
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Service/Credit.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/GatePass/GatePassHistory.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Widget/ApprovalButton.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Widget/FromToWidget.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
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
  @override
  void initState() {
    widget.locale;
    super.initState();
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
              locale: widget.locale,
            )
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            thickness: 2,
          ),
          //From-To
          FromToWidget(selectedFrom: selectedFrom, selectedTo: selectedTo),
          //Send Request message
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: theme.getDarkTheme?Colors.white:themeColor.appBarColor,
                ),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  style:GoogleFonts.merriweather(
                    fontWeight: FontWeight.w400,
                    fontSize: 18
                  ),
                  minLines: 15,
                  maxLines: 15,
                  controller: message,
                  decoration: InputDecoration(
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
                print('Insuffient Balence');
                studentCredit.updateStudentCreditToZero(student.id, 0);
              }
              else{
                studentCredit.updateStudentCredit(student.id, credit);
              }
            
            },
          )
        ],
      ),
    );
  }
}

