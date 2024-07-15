class QuizModel {
  String? score;
  final List<String> options;
  final String question;

  QuizModel({required this.options, required this.question, this.score});

  List questionsList = [
    {
      'question': 'this is the first question',
      'options': ['first ', 'second', ' third', 'fourth'],
    }
  ];
}
