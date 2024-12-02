import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp3/models/question.dart';
import 'package:quizapp3/services/database.dart';
import 'package:quizapp3/views/result.dart';
import 'package:quizapp3/widgets/quiz_play_widgets.dart';
import 'package:quizapp3/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizID;

  const PlayQuiz({super.key, required this.quizID});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  final DatabaseService databaseService = DatabaseService();
  QuerySnapshot? questionsSnapshot;

  Question getQuestionFromDatasnapshot(DocumentSnapshot questionSnapshot) {
    Map<String, dynamic> questionData =
        questionSnapshot.data() as Map<String, dynamic>? ?? {};

    List<String> options = [
      questionData["option1"] ?? "",
      questionData["option2"] ?? "",
      questionData["option3"] ?? "",
      questionData["option4"] ?? "",
    ];

    options.shuffle();

    return Question(
      question: questionData["question"] ?? "No question provided",
      option1: options[0],
      option2: options[1],
      option3: options[2],
      option4: options[3],
      correctOption: questionData["option1"] ?? "",
      answered: false,
    );
  }

  @override
  void initState() {
    super.initState();
    databaseService.getQuizDatas(widget.quizID).then((value) {
      setState(() {
        questionsSnapshot = value;
        _notAttempted = value.docs.length;
        _correct = 0;
        _incorrect = 0;
        total = value.docs.length;
      });
    }).catchError((error) {
      print("Error fetching quiz data: $error");
    });
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
      body: questionsSnapshot == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: questionsSnapshot!.docs.length,
              itemBuilder: (context, index) {
                return QuizPlayItem(
                  question: getQuestionFromDatasnapshot(
                      questionsSnapshot!.docs[index]),
                  index: index,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Results(correct: _correct, incorrect: _incorrect, total: total)));
      }),
    );
  }
}

class QuizPlayItem extends StatefulWidget {
  final Question question;
  final int index;

  const QuizPlayItem({super.key, required this.question, required this.index});

  @override
  State<QuizPlayItem> createState() => _QuizPlayItemState();
}

class _QuizPlayItemState extends State<QuizPlayItem> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Q${widget.index + 1}  ${widget.question.question}",
              style: TextStyle(fontSize: 18, color: Colors.black87)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                optionSelected = widget.question.option1;
                widget.question.answered = true;
                _notAttempted = _notAttempted - 1;
                if (widget.question.option1 == widget.question.correctOption) {
                  _correct = _correct + 1;
                  setState(() {});
                } else {
                  _incorrect = _incorrect + 1;
                  setState(() {});
                }
              }
            },
            child: OptionItem(
                option: "A",
                description: widget.question.option1,
                correctAnswer: widget.question.correctOption,
                optionSelected: optionSelected),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                optionSelected = widget.question.option2;
                widget.question.answered = true;
                _notAttempted = _notAttempted - 1;
                if (widget.question.option2 == widget.question.correctOption) {
                  _correct = _correct + 1;
                  setState(() {});
                } else {
                  _incorrect = _incorrect + 1;
                  setState(() {});
                }
              }
            },
            child: OptionItem(
                option: "B",
                description: widget.question.option2,
                correctAnswer: widget.question.correctOption,
                optionSelected: optionSelected),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                optionSelected = widget.question.option3;
                widget.question.answered = true;
                _notAttempted = _notAttempted - 1;
                if (widget.question.option3 == widget.question.correctOption) {
                  _correct = _correct + 1;
                  setState(() {});
                } else {
                  _incorrect = _incorrect + 1;
                  setState(() {});
                }
              }
            },
            child: OptionItem(
                option: "C",
                description: widget.question.option3,
                correctAnswer: widget.question.correctOption,
                optionSelected: optionSelected),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                optionSelected = widget.question.option4;
                widget.question.answered = true;
                _notAttempted = _notAttempted - 1;
                if (widget.question.option4 == widget.question.correctOption) {
                  _correct = _correct + 1;
                  setState(() {});
                } else {
                  _incorrect = _incorrect + 1;
                  setState(() {});
                }
              }
            },
            child: OptionItem(
                option: "D",
                description: widget.question.option4,
                correctAnswer: widget.question.correctOption,
                optionSelected: optionSelected),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
