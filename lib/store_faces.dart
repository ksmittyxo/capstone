class StoreFaces {
  final String id;
  final String svg;
  final String emotion;
  StoreFaces({
    required this.id,
    required this.svg,
    required this.emotion,
  });

  factory StoreFaces.fromJson(Map<String, dynamic> data) => StoreFaces(
    id: data['id'],
    svg: data['svg'],
    emotion: data['emotion'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'svg': svg,
    'emotion': emotion
  };
}