import 'package:flutter/material.dart';
import 'package:quizapp3/main.dart';
import 'package:quizapp3/services/database.dart';
import 'package:quizapp3/views/addquestion.dart';
import 'package:quizapp3/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String? imageURL, title, description;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;
  

  createQuiz() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String quizID = randomAlphaNumeric(16);
      Map<String, String> quizData = {
        "quizID": quizID,
        "imageURL": imageURL!,
        "title": title!,
        "description": description!,
      };

      await databaseService.addQuizData(quizData, quizID).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuestion(
                quizID: quizID,
              )));
        });
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
        iconTheme: const IconThemeData(color: Colors.black87),
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 26),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid Image URL" : null,
                      decoration: const InputDecoration(
                        hintText: "Image URL (Optional)",
                      ),
                      onChanged: (val) {
                        imageURL = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid Title" : null,
                      decoration: const InputDecoration(
                        hintText: "Title",
                      ),
                      onChanged: (val) {
                        title = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid Description" : null,
                      decoration: const InputDecoration(
                        hintText: "Description",
                      ),
                      onChanged: (val) {
                        description = val;
                      },
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        createQuiz();
                      },
                      child: mainButton(context: context, label: "Add Quiz"),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
