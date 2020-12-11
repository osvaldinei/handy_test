import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:handy_test/src/model/tweet_dto.dart';

import 'package:http/http.dart' as http;

class TweetService {
  static bool TIMEOUT = false;

  _Timeout() {
    print("TIMEOUT DE CONEXÃO");
    TIMEOUT = true;
  }

  Future<TweetDto> getTweet() async {
    final response = await http.get(
        'https://api.twitter.com/2/tweets/search/recent?query=from:realDonaldTrump&max_results=15&tweet.fields=author_id,created_at,lang,conversation_id,public_metrics,referenced_tweets&expansions=author_id&user.fields=name,id,description,profile_image_url',
        headers: {
          "Authorization": "Bearer " +
              'AAAAAAAAAAAAAAAAAAAAAJMCKgEAAAAAizacl82xUwDCJCmUJpC5kDcIJ1o%3DOtmSUl64tIYEzkZFcwWlKsvrBYp0Mu79GgwVhjrPZlwfKLo5JZ'
        }).timeout(const Duration(seconds: 10), onTimeout: () => _Timeout());

    // print('Response getTweet: ' +
    //     response.statusCode.toString() +
    //     response.body.toString());

    if (response.statusCode == 200) {
      final TweetDto tweetDto =
          TweetDto.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return tweetDto;
    } else {
      throw Exception('Erro ao realizar busca por Tweet');
    }
  }
}
