import 'question.dart';

class Survey {
  final String id;
  final String title;
  final List<Question> questions;

  const Survey({
    required this.id,
    required this.title,
    required this.questions,
  });
}
