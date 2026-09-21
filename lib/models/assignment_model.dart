class Assignment {
  final String title;
  bool isCompleted;

  Assignment({
    required this.title,
    this.isCompleted = false,
  });

  Assignment copyWith({String? title, bool? isCompleted}) {
    return Assignment(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}