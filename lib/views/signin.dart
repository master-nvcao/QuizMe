import 'package:flutter/material.dart';
import 'package:quizapp3/services/auth.dart';
import 'package:quizapp3/views/home.dart';
import 'package:quizapp3/views/signup.dart';
import 'package:quizapp3/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  AuthService authService = new AuthService();

  bool isLoading = false;

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService.loginEmailAndPassword(email!, password!).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      });
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
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
      body: isLoading
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
                        login();
                      },
                      child: mainButton(context: context, label: "Login"),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't Have an account ? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()),
                            );
                          },
                          child: const Text("Register",
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
