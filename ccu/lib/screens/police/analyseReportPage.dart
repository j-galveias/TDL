import 'package:CCU/models/report.dart';
import 'package:CCU/screens/loading.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/database.dart';
import 'package:flutter/material.dart';

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
                    child: Text(widget.report.location,
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
                    child: Text(widget.report.date,
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
                            await DatabaseService(uid: AuthService().getCurrentUser().uid).updateReport(widget.report, "Accepted");
                            Navigator.pop(context);
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
                            await DatabaseService(uid: AuthService().getCurrentUser().uid).updateReport(widget.report, "Rejected");
                            Navigator.pop(context);
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