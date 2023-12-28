
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Service/FormService.dart';
import 'package:kcgerp/Model/Form.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/Additional/Loader.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  static const route = '/History';
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<FormModel>? fetchFromForm;
  FormService _formService = FormService();
  void retreive()async{
    fetchFromForm = await  _formService.DisplayForm(context: context);
    setState(() {
      
    });
  }
  @override
  void initState() {
    retreive();
    super.initState();
  }
    @override
  void dispose() {
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    double totalSpend = fetchFromForm?.fold(0, (sum, form) => sum! + form.spent) ?? 0.0;
    final theme = Provider.of<DarkThemeProvider>(context);
    return fetchFromForm==null?Loader() :Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.history,
          style: GoogleFonts.merriweather(),
        ),
        backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.backgroundColor,
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 5),
            child: Text(
              '${S.current.totalspend}:\$${totalSpend.toStringAsFixed(0)}',
              style: GoogleFonts.merriweather(
                fontSize: 16
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: fetchFromForm!.length,
              itemBuilder:(context, index) {
                final reversedIndex = fetchFromForm!.length - 1 - index;
                final form = fetchFromForm![reversedIndex]; // Get data in reverse order
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: theme.getDarkTheme?Color.fromARGB(255, 21, 76, 97):Color.fromARGB(255, 255, 255, 255),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          //Display Title, Request and Approval 
                          Align(
                            alignment: Alignment(-0.9, -0.7),
                            child: Text(
                              form.formtype,
                              style: GoogleFonts.merriweather(
                                color:theme.getDarkTheme ? Colors.white:Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          
                          //Display Request and Approval 
                          Align(
                            alignment: Alignment(0.95, -0.8),
                            child: Card(
                              color:form.response=='Requested'?
                              Colors.orange:
                              form.response=='Accepted'?
                              Colors.green:Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  form.response=='Requested'?
                              'Requested :|':
                              form.response=='Accepted'?
                              'Accepted :)':'Rejected :(',
                                  style: GoogleFonts.merriweather(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          //Display From, To and No of Days
                          Align(
                            alignment: Alignment(-0.9, 0.2),
                            child: Text(
                              '${S.current.from}:${form.from}\n${S.current.to}:${form.to}',
                              style: GoogleFonts.merriweather(
                                color:theme.getDarkTheme ? Colors.white:Colors.black,
                              ),
                            ),
                          ),
                          
                          //Display No of Days
                          Align(
                            alignment: Alignment(0.9, 0.2),
                            child: Text(
                              '${S.current.noofdays}:${form.no_of_days}',
                              style: GoogleFonts.merriweather(
                                color:theme.getDarkTheme ? Colors.white:Colors.black,
                              ),
                            ),
                          ),
                          
                          //Credit Spend
                          Align(
                            alignment: Alignment(0.9, 0.8),
                            child: Text(
                              '\$${form.spent}',
                              style: GoogleFonts.merriweather(
                                fontSize: 20,
                                color: Colors.green
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}