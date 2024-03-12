class JournalModel {
  final String id;
  final String date;
  final String title;
  final String reflection;
  final String emotion;
  final String face;
  JournalModel({
    required this.id,
    required this.date,
    required this.title,
    required this.reflection,
    required this.emotion,
    required this.face,
  });

  factory JournalModel.fromJson(Map<String, dynamic> data) => JournalModel(
    id: data['id'],
    date: data['date'],
    title: data['title'],
    reflection: data['reflection'],
    emotion: data['emotion'],
    face: data['face'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'date': date,
    'title': title,
    'reflection': reflection,
    'emotion': emotion,
    'face': face
  };
}