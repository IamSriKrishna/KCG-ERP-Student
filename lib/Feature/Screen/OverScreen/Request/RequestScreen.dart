import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/CustomSfCalendar.dart';
import 'package:kcgerp/Feature/Service/Authservice.dart';
import 'package:kcgerp/Model/approval.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/GatePass/GatePass.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/ODScreen/ODScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/Widget/CustomApprovalWidget.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/CustomSliverAppbar.dart/CustomApprovalSliverAppBar.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  AuthService _authService = AuthService();
  @override
  void initState() {
    LoadUp();
    super.initState();
  }
  void LoadUp()async{
    await _authService.getUserData(context);
    setState(() {
      
    });
  }
  @override
  void didChangeDependencies() {
    LoadUp();
    setState(() {
      
    });
    super.didChangeDependencies();
  }
  final List<Approval> approval = [
    Approval(
      credit:100,
      image: 'asset/forms/od.png',
      percent: 75.5,
      approvalElaborate: S.current.ondutyDetails,
      approval: S.current.onduty, 
      color:  const LinearGradient(
      colors: [
          Color.fromRGBO(254, 138, 138, 1),
          Color.fromRGBO(237, 90, 90, 1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
        ), 
      ),
    Approval(
      credit:150,
      image: 'asset/forms/leave.png',
      percent: 75.5,
      approvalElaborate: S.current.leaveDetails,
      approval: S.current.leave, 
      color:  const LinearGradient(
      colors: [
        Color.fromARGB(255, 210, 161, 250),
        Color.fromRGBO(175, 75, 255, 1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
        ), 
      ),
    Approval(
      credit:200,
      image: 'asset/forms/gate.png',
      percent: 75.5,
      approvalElaborate: S.current.gatePassDetails,
      approval: S.current.gatePass, 
      color:   const LinearGradient(
        colors: [
          Color.fromRGBO(247, 180, 142, 1),
          Color.fromRGBO(255, 121, 44, 1),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
      ),  
    ),
  ];
  Future<void> onRefresh()async{
    LoadUp();
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:theme.getDarkTheme?themeColor.darkTheme: themeColor.backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CustomApprovalSliverAppBar(
              text: S.current.approval,
              leadingWidth: 0,
            )
          ];
        },
        body: LiquidPullToRefresh(
          onRefresh: onRefresh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.8
                ),
              physics: const BouncingScrollPhysics(),
              itemCount: approval.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if(approval[index].credit == approval[0].credit){
                      Navigator.pushNamed(
                        context, 
                        ODScreen.route,
                        arguments: {
                          'credit':approval[0].credit,
                          'color':approval[0].color
                        }
                      );
                    }
                    else if(approval[index].credit == approval[1].credit){
                      Navigator.pushNamed(
                        context,
                        CustomSFCalendar.route,
                        arguments: {
                          'credit':approval[1].credit,
                          'color':approval[1].color
                        }
                      );
                    }
                    else{
                      Navigator.pushNamed(
                        context, 
                        GatePassScreen.route,
                        arguments: {
                          'credit':approval[2].credit
                        }
                      );
                    }
                  },
                  child: CustomApprovalWidget(
                    color: approval[index].color, 
                    title: approval[index].approval, 
                    detail: approval[index].approvalElaborate, 
                    credit: approval[index].credit, 
                    image: approval[index].image
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
