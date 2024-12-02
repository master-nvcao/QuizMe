import 'package:flutter/material.dart';
import 'package:quizapp3/services/database.dart';
import 'package:quizapp3/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizID;
  const AddQuestion({super.key, required this.quizID});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String? question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionData = {
        "question": question!,
        "option1": option1!,
        "option2": option2!,
        "option3": option3!,
        "option4": option4!,
      };

      await databaseService
          .addQuestionData(questionData, widget.quizID)
          .then((value) {
        setState(() {
          _isLoading = false;
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
                          val!.isEmpty ? "Enter a valid Question" : null,
                      decoration: const InputDecoration(
                        hintText: "Question",
                      ),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid Option 1" : null,
                      decoration: const InputDecoration(
                        hintText: "Option 1 (Correct Answer)",
                      ),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid Option 2" : null,
                      decoration: const InputDecoration(
                        hintText: "Option 2",
                      ),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid Option 3" : null,
                      decoration: const InputDecoration(
                        hintText: "Option 3",
                      ),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter a valid Option 4" : null,
                      decoration: const InputDecoration(
                        hintText: "Option 4",
                      ),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: mainButton(
                              context: context,
                              label: "Confirm",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                        SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            uploadQuestionData();
                          },
                          child: mainButton(
                              context: context,
                              label: "Add Question",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
          ),
    );
  }
}
