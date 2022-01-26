import 'package:CCU/models/report.dart';
import 'package:CCU/screens/loading.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/contractLinking.dart';
import 'package:CCU/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyseReportPage extends StatefulWidget {
  Report report;

  AnalyseReportPage({required this.report, Key? key}) : super(key: key);

  @override
  _AnalyseReportPageState createState() => _AnalyseReportPageState();
}

class _AnalyseReportPageState extends State<AnalyseReportPage> {
  bool isLoading = false;
  final double topHeight = 150;
  final double profileImageHeight = 122;

  @override
  Widget build(BuildContext context) {
    //final contractLink = Provider.of<ContractLinking>(context);


    if(isLoading){
      return Loading();
    }
    return SafeArea(
        child: Scaffold(
          body: 
          Column(
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: Colors.blue,
                    width: double.infinity,
                    height: topHeight,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("TDL", 
                        style:
                          TextStyle(
                            color: Colors.white,
                            fontSize: 50
                          ),
                      ),
                    ),
                  ),
                  Center(
                    child: 
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: Text("Report Submitted",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      )
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 3)
                  ),
                  height: 200,
                  child: Image(image: NetworkImage(widget.report.image)),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text("Description:", 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Container(
                      height: 100,
                      width: 260,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(widget.report.description,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 8, 0),
                    child: Text("Type:",
                      //textAlign: TextAlign.end, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(widget.report.infraction,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 8, 0),
                    child: Text("License:\nPlate",
                      //textAlign: TextAlign.end, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(widget.report.licensePlate,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 8, 0),
                    child: Text("Location:",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: widget.report.location.indexOf(',') != null ? Text(widget.report.location.substring(0, widget.report.location.indexOf(',')) ,
                      style: TextStyle(fontSize: 18),
                    )
                    :
                    Text(widget.report.location,
                      style: TextStyle(fontSize: 18),  
                    )
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 8, 0),
                    child: Text("Date:",
                      //textAlign: TextAlign.end, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(widget.report.date.substring(0, 16),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                child:
                widget.report.status != "To be reviewed" ?
                  Container(
                      height: 50,
                      width: 110,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Close", style: TextStyle(fontSize: 22),),
                      ),
                    )
                  :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 110,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  elevation: 5.0,
                                  backgroundColor: Colors.blue.shade100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text("Accept?", style: TextStyle(fontSize: 25, color: Colors.blue.shade700),),
                                  content: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Are you sure you want to Accept?", style: TextStyle(fontSize: 20, color: Colors.blue.shade700),),
                                        SizedBox(height: 30,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No', style: TextStyle(color: Colors.blue.shade50),),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () async {
                                                String name = await DatabaseService(uid: AuthService().getCurrentUser().uid).updateReport(widget.report, "Accepted");

                                                var count = 0;
                                                Navigator.of(context).popUntil((_) => count++ >= 2);
                                              },
                                              child: Text('Yes', style: TextStyle(color: Colors.blue.shade50),),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                          },
                          child: Text("Accept", style: TextStyle(fontSize: 22),),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 110,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  elevation: 5.0,
                                  backgroundColor: Colors.blue.shade100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text("Reject?", style: TextStyle(fontSize: 25, color: Colors.blue.shade700),),
                                  content: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Are you sure you want to Reject?", style: TextStyle(fontSize: 20, color: Colors.blue.shade700),),
                                        SizedBox(height: 30,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No', style: TextStyle(color: Colors.blue.shade50),),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () async {
                                                await DatabaseService(uid: AuthService().getCurrentUser().uid).updateReport(widget.report, "Rejected");

                                                var count = 0;
                                                Navigator.of(context).popUntil((_) => count++ >= 2);
                                              },
                                              child: Text('Yes', style: TextStyle(color: Colors.blue.shade50),),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                          },
                          child: Text("Reject", style: TextStyle(fontSize: 22),),
                        ),
                      ),
                    ],
                  )
              ),
            ]
          ),
        )
    );
  }

}