class QuizQuestion {
  final String question;
  final String image;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.image,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  /// Factory constructor untuk mempermudah konversi dari Map (jika dibutuhkan)
  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      question: map['question'] as String,
      image: map['image'] as String,
      options: List<String>.from(map['options'] as List),
      correctAnswer: map['correctAnswer'] as String,
      explanation: map['explanation'] as String,
    );
  }
}
