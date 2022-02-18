import 'package:flutter/material.dart';
import 'package:padvisor/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign up to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(
              Icons.person,
            ),
            label: const Text(
              'Sign in',
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(
                  // decoration:
                  //     textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter an email';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  // decoration:
                  //     textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val!.length < 6
                      ? 'Enter a password 6 chars or long'
                      : null,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(
                        email,
                        password,
                      );
                      if (result == null) {
                        setState(() {
                          error = 'please supply a valid email';
                          loading = false;
                        });
                      }
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink)),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
