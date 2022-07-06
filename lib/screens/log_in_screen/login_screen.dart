import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custome_text.dart';

class LogInScreen extends StatefulWidget {
  static const namedRoute = '/log_in';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var _formkey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  _submitForm() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }

    _formkey.currentState!.save();
    try {
      await context.read<AuthProvider>().signInWithEmailAndPassword(
          context: context, email: _email!, password: _password!);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Somrthing went Wrong')));
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomeText(
                label: 'Welcome, ',
                color: Colors.black,
                size: 32,
              ),
              const CustomeText(
                label: 'please enter your email and password to login, ',
                color: Colors.black,
                size: 16,
              ),
              SizedBox(
                height: 50,
              ),
              SingleChildScrollView(
                child: Container(
                  //margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.88,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 227, 227, 227),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomeText(
                          label: 'Email',
                          color: Colors.black,
                          size: 12,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('please enter a user Email')));
                            } else if (!value.contains('@')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('please enter a valid email')));
                            }
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                          decoration: InputDecoration(
                              labelText: 'email@domain',
                              fillColor: Colors.grey[300],
                              filled: true,
                              border: InputBorder.none),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const CustomeText(
                          label: 'Password,',
                          color: Colors.black,
                          size: 12,
                        ),
                        TextFormField(
                          validator: ((value) {
                            if (value == null || value.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'password must be at least 6 charectors')));
                            }
                          }),
                          onSaved: (value) {
                            _password = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "******",
                              fillColor: Colors.grey[300],
                              filled: true,
                              border: InputBorder.none),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.77,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await _submitForm();
                                    // Navigator.of(context).pushReplacementNamed(
                                    //     HomeScreen.namedRoute);
                                  },
                                  child: Text('LogIn'))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
