import 'package:CCU/screens/loading.dart';
import 'package:CCU/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final double topHeight = 230;
  final double profileImageHeight = 122;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  var _email_controller = TextEditingController();
  var _password_controller = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  GlobalKey globalKey = GlobalKey();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    final top = topHeight - profileImageHeight / 2;
    final bottom = profileImageHeight / 2;

    return loading
        ? Loading()
        : Material(
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
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
                                            key: globalKey,
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
                                                  prefixIcon:
                                                      Icon(Icons.email_outlined, color: Colors.blue, size: 25,),
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
                                                textInputAction: TextInputAction.done,
                                                obscureText: true,
                                                onChanged: (val) {
                                                  setState(() => password = val);
                                                },
                                                focusNode: _passwordFocus,
                                                controller: _password_controller,
                                                onFieldSubmitted: (val) {
                                                  _passwordFocus.unfocus();
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true,
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
                                                      Icon(Icons.lock_outline_rounded, color: Colors.blue, size: 25,),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      error,
                                      style: TextStyle(color: Colors.red, fontSize: 14),
                                    ),
                                    SizedBox(height:25),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 340,
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
                                  dynamic result = await _auth.signInEmailAndPassword(email, password);
                                  print(result);
                                  if (result == null) {
                                    setState(() {
                                      error = 'WRONG EMAIL OR PASSWORD';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              child: Text(
                                'Login',
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
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                        letterSpacing: 1.5
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          padding: EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          elevation: 80.0,
                          shape: Border(
                            bottom: BorderSide(
                            width: 2.0, color: Colors.lightBlue.shade900)),
                          child: Container(
                            width: 250,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/psp1.png'),
                                  fit: BoxFit.cover),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" "),
                            ),
                          ),
                          // ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                            //.registerEmailAndPasswordPolice();
                            .signInEmailAndPassword("police@mail.com", "123456");
                            print(result);
                            if (result == null) {
                              setState(() {
                                error = 'WRONG EMAIL OR PASSWORD';
                                loading = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60,)
                ],
              ),
            ),
          );
  }
}
