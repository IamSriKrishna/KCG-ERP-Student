import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Sql/GatePassSQL.dart';

class GatePassHistory extends StatefulWidget {
  static const route = '/GatePassHistory';
  const GatePassHistory({super.key});

  @override
  State<GatePassHistory> createState() => _GatePassHistoryState();
}

class _GatePassHistoryState extends State<GatePassHistory> {
  List<Map<String,dynamic>> _gatepass= [];

  void _refreshArticle()async{
    final data = await GatePassSQL.getItems();
    setState(() {
      _gatepass = data;
    });
    print('Number Of Items ${_gatepass.length}'); 
  }
  @override
  void initState() {
    _refreshArticle();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gate Pass History',
          style: GoogleFonts.merriweather(),
        ),
      ),
      body: ListView.builder(
        itemCount: _gatepass.length,
        itemBuilder:(context, index) => Text(_gatepass[index]['reason']),
      ),
    );
  }
}