// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class News {
  final int id;
  final String? title;
  final String? newsUrl;
  final String? source;
  final List<String>? keywords;
  final String? creator;
  final String? videoUrl;
  final String? imageUrl;
  final String? descriptions;
  final String? content;
  final String? category;
  final String? language;
  final DateTime? pubDate;
  News({
    required this.id,
    this.title,
    this.newsUrl,
    this.source,
    this.keywords,
    this.creator,
    this.videoUrl,
    this.imageUrl,
    this.descriptions,
    this.content,
    this.category,
    this.language,
    this.pubDate,
  });

  News copyWith({
    String? title,
    String? newsUrl,
    String? source,
    List<String>? keywords,
    String? creator,
    String? videoUrl,
    String? imageUrl,
    String? descriptions,
    String? content,
    String? category,
    String? language,
    DateTime? pubDate,
  }) {
    return News(
      id: id,
      title: title ?? this.title,
      newsUrl: newsUrl ?? this.newsUrl,
      source: source ?? this.source,
      keywords: keywords ?? this.keywords,
      creator: creator ?? this.creator,
      videoUrl: videoUrl ?? this.videoUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      descriptions: descriptions ?? this.descriptions,
      content: content ?? this.content,
      category: category ?? this.category,
      language: language ?? this.language,
      pubDate: pubDate ?? this.pubDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'newsUrl': newsUrl,
      'source': source,
      'keywords': keywords,
      'creator': creator,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'descriptions': descriptions,
      'content': content,
      'category': category,
      'language': language,
      'pubDate': pubDate?.millisecondsSinceEpoch,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'],
      title: map['title'] != null ? map['title'] as String : null,
      newsUrl: map['newsUrl'] != null ? map['newsUrl'] as String : null,
      source: map['source'] != null ? map['source'] as String : null,
      keywords: map['keywords'] != null
          ? List<String>.from((map['keywords'] as List<String>))
          : null,
      creator: map['creator'] != null ? map['creator'] as String : null,
      videoUrl: map['videoUrl'] != null ? map['videoUrl'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      descriptions:
          map['descriptions'] != null ? map['descriptions'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      pubDate: map['pubDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['pubDate'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) =>
      News.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
