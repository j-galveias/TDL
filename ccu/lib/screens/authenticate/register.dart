import 'package:CCU/screens/loading.dart';
import 'package:CCU/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String error = '';
  bool loading = false;

  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  TextEditingController _name_controller = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
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
                      'Register',
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
                                val.isEmpty ? 'Enter a name' : null,
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.black45),
                              ),
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  color: Colors.black45, fontSize: 22),
                              alignLabelWithHint: true,
                              hintText: 'Enter your name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: Icon(Icons.account_box,
                                  color: Colors.black45),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                        dynamic result = await _auth.registerEmailAndPassword(
                            email, password, name);
                        if (result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                            loading = false;
                          });
                        }
                      }
                    },
                    color: Colors.blue,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
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
                    'Already have an account ?',
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
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

    /*Scaffold(
            backgroundColor: Colors.amber[200],
            appBar: AppBar(
              backgroundColor: Colors.amber[500],
              elevation: 0.0,
              title: Text('Sign Up'),
              actions: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    widget.toggleView();
                  },
                  color: Colors.amber[500],
                  label: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an name' : null,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      focusNode: _nameFocus,
                      controller: _name_controller,
                      onFieldSubmitted: (val) {
                        _fieldFocusChange(context, _nameFocus, _nameFocus);
                      },
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailFocus,
                      controller: _email_controller,
                      onFieldSubmitted: (val) {
                        _fieldFocusChange(context, _emailFocus, _passwordFocus);
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Password must have more than 6 characters'
                          : null,
                      textInputAction: TextInputAction.done,
                      focusNode: _passwordFocus,
                      controller: _password_controller,
                      onFieldSubmitted: (val) {
                        _passwordFocus.unfocus();
                      },
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.orange,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerEmailAndPassword(
                              email, password, name);
                          if (result == null) {
                            setState(() {
                              error = 'please supply a valid email';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );*/
  }
}
