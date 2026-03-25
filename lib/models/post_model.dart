class Post {
  final int? id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;

  Post({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Map (from SQLite) into a Post Object
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  // Convert a Post Object into a Map (to save in SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Helper method to create a copy of a post with updated fields
  Post copyWith({
    int? id,
    String? title,
    String? content,
    String? createdAt,
    String? updatedAt,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}