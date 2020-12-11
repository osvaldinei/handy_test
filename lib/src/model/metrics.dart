
class Metrics{
   int retweetCount;
   int replyCount;
   int likeCount;
   int quoteCount;


  Metrics({
  this.retweetCount,
  this.replyCount,
  this.likeCount,
  this.quoteCount,
  });

   factory Metrics.fromJson(Map<String, dynamic> json) {
    return Metrics(
      retweetCount: json['retweet_count'],
      replyCount: json['reply_count'],
      likeCount: json['like_count'],
      quoteCount: json['quote_count'],
    );
  }

}