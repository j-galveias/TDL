import 'package:CCU/screens/camera/submitedReportPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

const kGoogleApiKey = "AIzaSyASCVlOZv4Uo30hDEO7qcTRdcC7MeVYVJw";

class ReportFormPage extends StatefulWidget {

  final XFile? previewFile;
  const ReportFormPage({this.previewFile, Key? key}) : super(key: key);

  @override
  _ReportFormPageState createState() => _ReportFormPageState();
}

class _ReportFormPageState extends State<ReportFormPage>{
  final double topHeight = 150;

  // text field state
  String description = "";
  String? infraction = "Select Infraction";
  String licensePlate = '';
  String location = "";
  String error = '';
  String lat = "";
  String lon = '';

  final infractions = ["Select Infraction", "Parking", "Speeding", "Failing to signal", "Failing to stop"];

  TextEditingController _description_controller = TextEditingController();
  TextEditingController _licensePlate_controller = TextEditingController();
  TextEditingController _location_controller = TextEditingController();

  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _licensePlateFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  DropdownMenuItem<String> _buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontSize: 20,color: Colors.blue),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: 
          SingleChildScrollView(
            child: Column(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(280, 0, 0, 0),
                      child: Column(
                        children: [
                          IconButton (
                            icon: 
                              Icon(
                                Icons.info,
                                size: 60,
                                color: Colors.white,
                              ), 
                              onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: 
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                          child: Text("Report",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        )
                    )
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          color: Colors.lightBlue.shade50,
                          child: GooglePlaceAutoCompleteTextField(
                              textEditingController: _location_controller,
                              googleAPIKey: "AIzaSyASCVlOZv4Uo30hDEO7qcTRdcC7MeVYVJw",
                              inputDecoration: InputDecoration(
                                enabledBorder: 
                                  OutlineInputBorder(
                                    borderSide: 
                                      BorderSide(color: Colors.blue.shade700, width: 1)
                                  ),
                                focusedBorder: 
                                  OutlineInputBorder(borderSide: 
                                    BorderSide(color: Colors.blue.shade700, width: 3.0)
                                  ),
                                hintText: 'Location:',
                                hintStyle: TextStyle(color: Colors.blue[500]),
                              ),
                              debounceTime: 800,
                              countries: ["pt"],
                              isLatLngRequired: true,
                              getPlaceDetailWithLatLng: (Prediction prediction) {
                                lat = prediction.lat.toString();
                                lon = prediction.lng.toString();
                                print("placeDetails" + prediction.lng.toString());
                              },
                              itmClick: (Prediction prediction) {
                                _location_controller.text = prediction.description!;
                                location = _location_controller.text;
                                _location_controller.selection = TextSelection.fromPosition(
                                    TextPosition(offset: prediction.description!.length));
                              }
                              // default 600 ms ,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          color: Colors.lightBlue.shade50,
                          height: 200,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            expands: true,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a description' : null,
                            cursorColor: Colors.black45,
                            textInputAction: TextInputAction.done,
                            controller: _description_controller,
                            onFieldSubmitted: (val) {
                              _descriptionFocus.unfocus();
                            },
                            onChanged: (val) {
                              setState(() => description = val);
                            },
                            decoration: InputDecoration(
                              enabledBorder: 
                                OutlineInputBorder(
                                  borderSide: 
                                    BorderSide(color: Colors.blue.shade700, width: 1)
                                ),
                              focusedBorder: 
                                OutlineInputBorder(borderSide: 
                                  BorderSide(color: Colors.blue.shade700, width: 3.0)
                                ),
                              hintText: 'Description:',
                              hintStyle: TextStyle(color: Colors.blue[500]),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),                  
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(color: Colors.blue, width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.lightBlue.shade50)
                                  ),
                                ),
                                value: infraction,
                                isExpanded: true,
                                items: infractions.map(_buildMenuItem).toList(),
                                onChanged: (value) => setState(() => infraction = value),
                                validator: (val) => val == "Select Infraction"
                                  ? 'Select Infraction'
                                  : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          color: Colors.lightBlue.shade50,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            validator: (val) =>
                                val!.length != 6 ? 'Enter a License Plate' : null,
                            cursorColor: Colors.black45,
                            textInputAction: TextInputAction.next,
                            controller: _licensePlate_controller,
                            onFieldSubmitted: (val) {
                              _fieldFocusChange(
                                context, _licensePlateFocus, _locationFocus);},
                            onChanged: (val) {
                              setState(() => licensePlate = val);
                            },
                            decoration: InputDecoration(
                              enabledBorder: 
                                OutlineInputBorder(
                                  borderSide: 
                                    BorderSide(color: Colors.blue.shade700, width: 1)
                                ),
                              focusedBorder: 
                                OutlineInputBorder(borderSide: 
                                  BorderSide(color: Colors.blue.shade700, width: 3.0)
                                ),
                              hintText: 'License Plate: Ex(AA20AB)',
                              hintStyle: TextStyle(color: Colors.blue[500]),
                            ),
                          ),
                        ),
                      ),  
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: 
                              (context) => SubmitedReportPage(
                                previewFile: widget.previewFile,
                                description: description,
                                infraction: infraction,
                                licensePlate: licensePlate,
                                location: location,
                                lat: lat,
                                lon: lon,
                              )), ModalRoute.withName('/')); 
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),
             ]
            ),
          ),
        )
      );
  }
  /*Future<String> _handlePressButton() async {
      // show input autocomplete with selected mode
      // then get the Prediction selected
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        onError: onError,
        apiKey: kGoogleApiKey,
        mode: Mode.overlay,
        language: "pt",
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        components: [Component(Component.country, "pt")],
      );

      return await displayPrediction(p, context);
    }
    void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }*/
}

/*Future<String> displayPrediction(Prediction? p, BuildContext context) async {
  if (p != null) {
    // get detail (lat/lng)
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    return p.description!;
  }
  return "";
}*/
