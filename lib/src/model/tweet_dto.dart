import 'package:handy_test/src/model/tweet.dart';
import 'package:handy_test/src/model/user.dart';

class TweetDto {
  final List<Tweet> tweet;
  final List<User> user;

  TweetDto({
    this.tweet,
    this.user,
  });

  factory TweetDto.fromJson(Map<String, dynamic> json) {
    var listI = json['data'] as List;
    List<Tweet> listTweet = listI.map((i) => Tweet.fromJson(i)).toList();

    var listII = json['includes']['users'] as List;
    List<User> listUser = listII.map((i) => User.fromJson(i)).toList();

    
    return TweetDto(
      tweet: listTweet,
      user: listUser
    );
  }
}
