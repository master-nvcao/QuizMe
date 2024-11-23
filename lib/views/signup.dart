import 'package:flutter/material.dart';
import 'package:quizapp3/services/auth.dart';
import 'package:quizapp3/views/home.dart';
import 'package:quizapp3/views/signin.dart';
import 'package:quizapp3/widgets/widgets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String? email, password, firtname, lastname;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      authService.registerWithEmailAndPassword(email!, password!).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _isLoading
          ? Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val == null || val.isEmpty
                            ? "Enter a correct first name"
                            : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "First Name",
                      ),
                      onChanged: (val) {
                        firtname = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val == null || val.isEmpty
                            ? "Enter a correct last name"
                            : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Last Name",
                      ),
                      onChanged: (val) {
                        lastname = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val == null || val.isEmpty
                            ? "Enter a correct email"
                            : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val == null || val.isEmpty
                            ? "Enter a correct password"
                            : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        signUp();
                      },
                      child: mainButton(context: context, label: "Register"),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()),
                            );
                          },
                          child: const Text("Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
    );
  }
}
