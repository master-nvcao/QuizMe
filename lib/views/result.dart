import 'package:flutter/material.dart';
import 'package:quizapp3/views/home.dart';
import 'package:quizapp3/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results(
      {super.key,
      required this.correct,
      required this.incorrect,
      required this.total});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.correct} / ${widget.total}",
                      style: TextStyle(fontSize: 25)),
                  const SizedBox(height: 12),
                  Text(
                      "You answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center),
                  
                ],
              ),
            ),
            
          ),
          GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: mainButton(
                      context: context,
                      label: "Go Back Home",
                      buttonWidth: MediaQuery.of(context).size.width / 1.1)
              ),
        ],
      ),
    );
  }
}
