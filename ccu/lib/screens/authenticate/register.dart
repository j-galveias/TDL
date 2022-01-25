import 'package:CCU/screens/loading.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/contractLinking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  final double topHeight = 230;
  final double profileImageHeight = 122;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String nif = '';
  String error = '';
  bool loading = false;

  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _nif_controller = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _nifFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    final top = topHeight - profileImageHeight / 2;
    final bottom = profileImageHeight / 2;
    //final contractLink = Provider.of<ContractLinking>(context);

    return loading
        ? Loading()
        : Material(
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children:[
                      Container(
                        margin: EdgeInsets.only(bottom: bottom),
                        color: Colors.blue,
                        width: double.infinity,
                        height: topHeight,
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                'TDL',
                                style: TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(Icons.directions_car, 
                              color: Colors.white,
                              size: 70,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 30.0),
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                              child: TextFormField(
                                                validator: (val) =>
                                                    val!.isEmpty ? 'Enter a name' : null,
                                                cursorColor: Colors.black45,
                                                keyboardType: TextInputType.name,
                                                textInputAction: TextInputAction.next,
                                                focusNode: _nameFocus,
                                                controller: _name_controller,
                                                onFieldSubmitted: (val) {
                                                  _fieldFocusChange(
                                                      context, _nameFocus, _emailFocus);
                                                },
                                                onChanged: (val) {
                                                  setState(() => name = val);
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                    EdgeInsets.symmetric(vertical: 15.0),
                                                  enabledBorder: 
                                                    UnderlineInputBorder(
                                                      borderSide: 
                                                        BorderSide(color: Colors.blue.shade700, width: 1)
                                                    ),
                                                  focusedBorder: 
                                                    UnderlineInputBorder(borderSide: 
                                                      BorderSide(color: Colors.blue.shade700, width: 3.0)
                                                    ),
                                                  hintText: 'Enter your name',
                                                  hintStyle: TextStyle(color: Colors.blue[500]),
                                                  prefixIcon: Icon(Icons.account_box,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 80,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                              child: TextFormField(
                                                validator: (val) =>
                                                    val!.isEmpty ? 'Enter an email' : null,
                                                cursorColor: Colors.black45,
                                                keyboardType: TextInputType.emailAddress,
                                                textInputAction: TextInputAction.next,
                                                focusNode: _emailFocus,
                                                controller: _email_controller,
                                                onFieldSubmitted: (val) {
                                                  _fieldFocusChange(
                                                      context, _emailFocus, _passwordFocus);
                                                },
                                                onChanged: (val) {
                                                  setState(() => email = val);
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                        EdgeInsets.symmetric(vertical: 15.0),
                                                      enabledBorder: 
                                                        UnderlineInputBorder(
                                                          borderSide: 
                                                            BorderSide(color: Colors.blue.shade700,width: 1)
                                                        ),
                                                      focusedBorder: 
                                                        UnderlineInputBorder(borderSide: 
                                                          BorderSide(color: Colors.blue.shade700,width: 3.0)
                                                        ),
                                                  hintText: 'Enter your email',
                                                  hintStyle: TextStyle(color: Colors.blue[500]),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                  prefixIcon:
                                                      Icon(Icons.email, color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 80,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                              child: TextFormField(
                                                validator: (val) => val!.length < 6
                                                    ? 'Password must have more than 6 characters'
                                                    : null,
                                                cursorColor: Colors.black45,
                                                textInputAction: TextInputAction.next,
                                                obscureText: true,
                                                onChanged: (val) {
                                                  setState(() => password = val);
                                                },
                                                focusNode: _passwordFocus,
                                                controller: _password_controller,
                                                onFieldSubmitted: (val) {
                                                  _fieldFocusChange(
                                                      context, _passwordFocus, _nifFocus);
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(vertical: 15.0),
                                                  enabledBorder: 
                                                    UnderlineInputBorder(borderSide: 
                                                      BorderSide(color: Colors.blue.shade700,width: 1)
                                                    ),
                                                  focusedBorder: 
                                                    UnderlineInputBorder(borderSide: 
                                                      BorderSide(color: Colors.blue.shade700,width: 3.0)
                                                    ),
                                                  hintText: 'Enter your password',
                                                  hintStyle: TextStyle(color: Colors.blue[500]),
                                                  prefixIcon:
                                                      Icon(Icons.lock, color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 80,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                              child: TextFormField(
                                                validator: (val) => val!.length != 6
                                                    ? 'License must have 6 characters'
                                                    : null,
                                                cursorColor: Colors.black45,
                                                keyboardType: TextInputType.number,
                                                textInputAction: TextInputAction.done,
                                                obscureText: false,
                                                onChanged: (val) {
                                                  setState(() => nif = val);
                                                },
                                                focusNode: _nifFocus,
                                                controller: _nif_controller,
                                                onFieldSubmitted: (val) {
                                                  _nifFocus.unfocus();
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(vertical: 15.0),
                                                  enabledBorder: 
                                                    UnderlineInputBorder(borderSide: 
                                                      BorderSide(color: Colors.blue.shade700,width: 1)
                                                    ),
                                                  focusedBorder: 
                                                    UnderlineInputBorder(borderSide: 
                                                      BorderSide(color: Colors.blue.shade700,width: 3.0)
                                                    ),
                                                  hintText: 'Enter your License Plate',
                                                  hintStyle: TextStyle(color: Colors.blue[500]),
                                                  prefixIconConstraints: BoxConstraints(
                                                    maxWidth: 100,
                                                    maxHeight: 100,
                                                  ),
                                                  prefixIcon:
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(7.0, 8.0, 7.0, 0),
                                                        child: ImageIcon(AssetImage("assets/id-card.png"),color: Colors.blue,size: 35,),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height:20),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 475,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.blue,
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth.registerEmailAndPassword(
                                    email, password, name, nif);
                                print("--------" + result.toString());
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                    loading = false;
                                  });
                                }else{
                                  /*dynamic result = await contractLink.addData(name);
                                  print(result);*/
                                }
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () async {
                      widget.toggleView();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        letterSpacing: 1.5,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        );
  }
}
