import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map<String, String> quizData, String quizID) async {
    try {
      await FirebaseFirestore.instance
          .collection("Quiz")
          .doc(quizID)
          .set(quizData);
    } catch (e) {
      print("Error adding quiz data: ${e.toString()}");
    }
  }

  Future<void> addQuestionData(Map<String, dynamic> questionData, String quizID) async {
    try {
      await FirebaseFirestore.instance
          .collection("Quiz")
          .doc(quizID)
          .collection("Question")
          .add(questionData); 
    } catch (e) {
      print("Error adding question data: ${e.toString()}");
    }
  }


}
