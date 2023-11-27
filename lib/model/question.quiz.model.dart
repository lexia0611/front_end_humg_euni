import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class QuestionQuizModel {
  int? id;
  int? quizId;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  QuestionQuizModel({
    this.id,
    this.quizId,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
  });

  QuestionQuizModel copyWith({
    int? id,
    int? quizId,
    String? question,
    String? option1,
    String? option2,
    String? option3,
    String? option4,
  }) {
    return QuestionQuizModel(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      question: question ?? this.question,
      option1: option1 ?? this.option1,
      option2: option2 ?? this.option2,
      option3: option3 ?? this.option3,
      option4: option4 ?? this.option4,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quizId': quizId,
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
    };
  }

  factory QuestionQuizModel.fromMap(Map<String, dynamic> map) {
    return QuestionQuizModel(
      id: map['id'] != null ? map['id'] as int : null,
      quizId: map['quizId'] != null ? map['quizId'] as int : null,
      question: map['question'] != null ? map['question'] as String : null,
      option1: map['option1'] != null ? map['option1'] as String : null,
      option2: map['option2'] != null ? map['option2'] as String : null,
      option3: map['option3'] != null ? map['option3'] as String : null,
      option4: map['option4'] != null ? map['option4'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionQuizModel.fromJson(String source) => QuestionQuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionQuizModel(id: $id, quizId: $quizId, question: $question, option1: $option1, option2: $option2, option3: $option3, option4: $option4)';
  }

  @override
  bool operator ==(covariant QuestionQuizModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.quizId == quizId &&
      other.question == question &&
      other.option1 == option1 &&
      other.option2 == option2 &&
      other.option3 == option3 &&
      other.option4 == option4;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      quizId.hashCode ^
      question.hashCode ^
      option1.hashCode ^
      option2.hashCode ^
      option3.hashCode ^
      option4.hashCode;
  }
}
