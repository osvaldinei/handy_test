import 'package:handy_test/src/model/metrics.dart';

class Tweet {
  final String id;
  final String name;
  final String createdAt;
  final String conversationId;
  final String authorId;
  final String lang;
  final String text;
  final Metrics metrics;

  Tweet(
      {this.id,
      this.name,
      this.createdAt,
      this.conversationId,
      this.authorId,
      this.lang,
      this.text,
      this.metrics});

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] as String,
      conversationId: json['conversation_id'] as String,
      authorId: json['author_id'] as String,
      lang: json['lang'] as String,
      text: json['text'] as String,
      metrics: Metrics.fromJson(json['public_metrics']),
    );
  }
}
