import 'package:CCU/screens/authenticate/register.dart';
import 'package:CCU/screens/loading.dart';
import 'package:CCU/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

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

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Material(
            child: Container(
              color: Colors.blue[700],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 80.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.black45),
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.black45, fontSize: 22),
                              alignLabelWithHint: true,
                              hintText: 'Enter your email',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon:
                                  Icon(Icons.email, color: Colors.black45),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (val) => val.length < 6
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.black45),
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.black45, fontSize: 22),
                              alignLabelWithHint: true,
                              hintText: 'Enter your password',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon:
                                  Icon(Icons.lock, color: Colors.black45),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signInEmailAndPassword(email, password);
                              print(result);
                              if (result == null) {
                                setState(() {
                                  error = 'WRONG EMAIL OR PASSWORD';
                                  loading = false;
                                });
                              }
                            }
                          },
                          color: Colors.blue,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Or',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth.signInWithGoogle();
                            print(result);
                          },
                          color: Colors.white,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/googleIcon.svg',
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  Divider(
                    color: Colors.black45,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Don\'t have an account yet?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () async {
                      widget.toggleView();
                    },
                    color: Colors.blue,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
