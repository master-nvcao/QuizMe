import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp3/services/database.dart';
import 'package:quizapp3/views/create_quiz.dart';
import 'package:quizapp3/views/play_quiz.dart';
import 'package:quizapp3/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot>? quizStream;
  DatabaseService databaseService = DatabaseService();

  Widget quizList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder<QuerySnapshot>(
        stream: quizStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs; // Use 'docs' instead of 'documents'

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final quizData =
                  docs[index].data() as Map<String, dynamic>; // Cast to Map
              return QuizItem(
                imageURL: quizData["imageURL"] ?? "",
                title: quizData["title"] ?? "",
                desc: quizData["description"] ?? "",
                quizID: quizData["quizID"],
              );
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateQuiz()),
          );
        },
      ),
    );
  }
}

class QuizItem extends StatelessWidget {
  final String imageURL;
  final String title;
  final String desc;
  final String quizID;

  const QuizItem(
      {super.key,
      required this.imageURL,
      required this.title,
      required this.desc,
      required this.quizID});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayQuiz(
              quizID: quizID,
            )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageURL,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
