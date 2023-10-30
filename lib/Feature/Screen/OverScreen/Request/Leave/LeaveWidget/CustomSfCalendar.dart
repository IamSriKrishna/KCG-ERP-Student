
import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/LeaveAppbar.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/LeaveDetailWidget.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Widget/CustomActionSlide.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomSFCalendar extends StatefulWidget {
  static const route = '/CustomSFCalendar';
  const CustomSFCalendar({Key? key}) : super(key: key);

  @override
  _CustomSFCalendarState createState() => _CustomSFCalendarState();
}

class _CustomSFCalendarState extends State<CustomSFCalendar>with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  PickerDateRange? _selectedRange; // To store the selected date range


  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this
    );
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final credit = args['credit'];
    final color = args['color'] as Gradient;
    final student = Provider.of<StudentProvider>(context).user;
    return Scaffold(
      appBar: LeaveAppBar(
        context: context,
        text: 'Selected No Of Days'
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: color
              ),
              child: SfDateRangePicker(
                minDate: DateTime.now(),
                maxDate: DateTime.now().add(Duration(days: 30)),
                enablePastDates: false,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(DateTime.now(), DateTime.now()),
                initialDisplayDate: DateTime.now(),
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  setState(() {
                    _selectedRange = args.value;
                  });
                  if(calculateTotalDaysSelected()<=2){
                    controller.animateTo(1);
                  }
                  else{
                    controller.animateTo(0.5);
                  }
                  print(_selectedRange!.startDate);
                },
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  todayTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                  blackoutDateTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                  disabledDatesTextStyle: TextStyle(
                    color: Color.fromARGB(77, 243, 242, 242),
                    fontSize: 14.0,
                  ),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                yearCellStyle: DateRangePickerYearCellStyle(
                  disabledDatesTextStyle: TextStyle(
                    color: Color.fromARGB(77, 243, 242, 242),
                    fontSize: 14.0,
                  ),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                selectionColor: Colors.white,
                rangeSelectionColor: Colors.white,
                todayHighlightColor: Colors.blue, // Replace 'themeColor.backgroundColor' with your desired color
                startRangeSelectionColor: Colors.green,
                endRangeSelectionColor: Colors.deepOrangeAccent,
              ),
            ),
          ),
          //Diplay Total Credit You having
          LeaveDetailsWidget(text: 'Credit You Have',hint: '${student.credit}',),
          //Diplay per Credit 
          LeaveDetailsWidget(text: 'Per Credit',hint: '${credit}',),
          //Diplay no of days selected
          LeaveDetailsWidget(text: 'Total days selected',hint: '${calculateTotalDaysSelected()}',),
          //Calulate no of days selected and credit
          LeaveDetailsWidget(text: 'Total Credit',hint: '${calculateTotalDaysSelected() * credit}',),
          // Container(
          //   alignment: Alignment.center,
          //   child: Lottie.asset('asset/lottie/house.json',height: 100,controller: controller))
        ],
      ),
      bottomNavigationBar: _selectedRange != null
    ? LeaveCustomActionButton(
        daySelected: calculateTotalDaysSelected(),
        perCredit: credit,
        StudentCredit: student.credit,
        startDate: _selectedRange!.startDate,
        endDate: _selectedRange!.endDate,
        color: color,
      )
    : NullCustomActionButton(
        daySelected: calculateTotalDaysSelected(),
        perCredit: credit,
        StudentCredit: student.credit,
        color: color,
    )
    );
  }
  
int calculateTotalDaysSelected() {
    if (_selectedRange != null &&
        _selectedRange!.startDate != null &&
        _selectedRange!.endDate != null) {
      return _selectedRange!.endDate!
          .difference(_selectedRange!.startDate!)
          .inDays +
          1;
    } else {
      return 0; // No range selected
    }
  }
  }
