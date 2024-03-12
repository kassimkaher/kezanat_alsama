import 'dart:developer';

import 'package:ramadan/src/core/resources/local_db.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/core/entity/work_entity.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';
import 'package:ramadan/utils/utils.dart';

class FireStoreRemote {
  static final dailyPosts = FirebaseFirestore.instance.collection('/posts');
  static final workToday = FirebaseFirestore.instance.collection('/work_today');
  static final calendar = FirebaseFirestore.instance.collection('/calendar');

  static Future<DataState<DocumentReference<Map<String, dynamic>>>> addWork(
      DailyWorkData dailyWorkData) async {
    try {
      final result = await workToday.add(dailyWorkData.toJson());
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(ApiError(code: 400, msg: "error"));
    }
  }

  static Future<DataState> updateWork(
      {required DailyWorkData dailyWorkData}) async {
    try {
      await dailyWorkData.refrence!.set(dailyWorkData.toJson());
      return const DataSuccess("");
    } catch (e) {
      kdp(name: "updateWork", msg: dailyWorkData.refrence, c: 'r');
      return DataFailed(ApiError(code: 400, msg: "msg"));
    }
  }

  static Future<DataState<DailyPostsModel>> getPostsApi() async {
    // final data = LocalDB.getPosts();

    // if (data != null &&
    //     (data.dateTime?.difference(DateTime.now()).inDays ?? 1) == 0) {
    //   return DataSuccess(data);
    // }
    try {
      final data = await dailyPosts.get();
      final List<DailyPostData> list = [];
      for (var element in data.docs) {
        try {
          final data = element.data();
          data['id'] = element.id;
          list.add(DailyPostData.fromJson(data));
        } catch (e) {}
      }

      if (list.isEmpty) {
        return const DataNotSet();
      }
      LocalDB.setPosts(DailyPostsModel(data: list, dateTime: DateTime.now()));

      return DataSuccess(DailyPostsModel(data: list, dateTime: DateTime.now()));
    } catch (e) {
      kdp(name: "getposts", msg: e.toString(), c: 'r');
      return DataFailed(ApiError(code: 0, msg: e.toString()));
    }
  }

  static Future<DataState<WorkEntity>> getWorkspi(
      {bool fromLocal = false}) async {
    final data = LocalDB.getDailyWorkFromLocal();
    if (fromLocal ||
        (appMode == AppMode.user &&
            data != null &&
            (data.dateTime?.difference(DateTime.now()).inDays ?? 1) == 0)) {
      return DataSuccess(WorkEntity(data, null));
    }
    try {
      final data = await workToday.get();

      final List<DailyWorkData> list = [];
      for (var element in data.docs) {
        try {
          final data = element.data();

          data['id'] = element.id;
          data['reference'] = element.reference;

          list.add(DailyWorkData.fromJson(data));
        } catch (e) {}
      }

      if (list.isEmpty) {
        return const DataNotSet();
      }
      LocalDB.setDailyWorkFromLocal(
          DailyWorkModel(data: list, dateTime: DateTime.now()));

      return DataSuccess(WorkEntity(
          DailyWorkModel(data: list, dateTime: DateTime.now()), data.docs));
    } catch (e) {
      kdp(name: "getWorkspi", msg: e.toString(), c: 'r');
      return DataFailed(ApiError(code: 0, msg: e.toString()));
    }
  }

  static Future<DataState<CalendarModel>> getCalendarApi() async {
    final datalocal = LocalDB.getCalendar();
    if (datalocal != null &&
        (datalocal.dateTime?.difference(DateTime.now()).inDays ?? 1) == 0 &&
        appMode == AppMode.user) {
      return DataSuccess(datalocal);
    }
    try {
      final data = await calendar.get();

      // data['id'] = data.docs.first.id;

      final cal = CalendarModel.fromJson(data.docs.first);
      log(cal.hijreYear.toString());
      LocalDB.setCalendar(cal);

      return DataSuccess(cal);
    } catch (e) {
      kdp(name: "getCalendarApi", msg: e.toString(), c: 'r');
      return DataFailed(ApiError(code: 0, msg: e.toString()));
    }
  }

  static Future<DataState> updateCalendarApi(
      CalendarModel calendarModel) async {
    try {
      await calendarModel.refrence!.set(calendarModel.toJson());
      return DataSuccess("");
    } catch (e) {
      kdp(name: "updateCalendarApi", msg: calendarModel.refrence, c: 'r');
      return DataFailed(ApiError(code: 400, msg: "msg"));
    }
  }

  static Future<DataState> deleteWork(String id) async {
    try {
      await workToday.doc().delete();
      return const DataSuccess("");
    } catch (e) {
      return DataFailed(ApiError(code: 400, msg: ""));
    }
  }
  // static final twitter = v2.TwitterApi(
  //   //! Authentication with OAuth2.0 is the default.
  //   //!
  //   //! Note that to use endpoints that require certain user permissions,
  //   //! such as Tweets and Likes, you need a token issued by OAuth2.0 PKCE.
  //   //!
  //   //! The easiest way to achieve authentication with OAuth 2.0 PKCE is
  //   //! to use [twitter_oauth2_pkce](https://pub.dev/packages/twitter_oauth2_pkce)!
  //   bearerToken:
  //       'AAAAAAAAAAAAAAAAAAAAALwWrgEAAAAAg13d6PlE4RiwINr17bmoF6K%2BtXc%3Dne6XshxJpKjzdyYv5YkUIZhUqugw8pzcFx6lyjUgvqXbV4odQA',

  //   //! Or perhaps you would prefer to use the good old OAuth1.0a method
  //   //! over the OAuth2.0 PKCE method. Then you can use the following code
  //   //! to set the OAuth1.0a tokens.
  //   //!
  //   //! However, note that some endpoints cannot be used for OAuth 1.0a method
  //   //! authentication.
  //   oauthTokens: v2.OAuthTokens(
  //     consumerKey: '51c8q7Mn6OsuhNiw2Hh4p7zY0',
  //     consumerSecret: 'PFeyZXcu2QF7Ir1YJC0Au2ZXz2e9THJoD7R2mUBHU7vBvuzbgW',
  //     accessToken: '1663661737197838337-hy8EVHIf8CFlimegbdj1B3gYr2VuZW',
  //     accessTokenSecret: 'DQV5SEt36mznW7LheI3JJ0SUAGKtu1EM1YzMhSGsoHpkM',
  //   ),

  //   //! Automatic retry is available when network error or server error
  //   //! are happened.
  //   retryConfig: v2.RetryConfig(
  //     maxAttempts: 5,
  //     onExecute: (event) => print(
  //       'Retry after ${event.intervalInSeconds} seconds... '
  //       '[${event.retryCount} times]',
  //     ),
  //   ),

  //   //! The default timeout is 10 seconds.
  //   timeout: Duration(seconds: 20),
  // );

  //boot name =Kezanat_alsama_bot

  // static connect2() {
  //   final bot = Bot(
  //     // Insert your bot token here
  //     token: '6421544813:AAH8xBSovB_OImOOzZx_pQtiTRIMUK6HmSE',
  //     // Once the bot is ready this function will be called
  //     // You can start the bot here
  //     onReady: (bot) => bot.start(clean: true),
  //     onStartFailed: (bot, e, s) => log('Start failed'),

  //     // Register a new callback for new updates
  //   );
  //   // bot.onCommand(command, (p0, p1) => null)
  //   bot.onUpdate((bot, update) async {
  //     // Send a message to the update chat with the received message
  //     log(update.message.toString());
  //     log("=================");
  //     bot.sendMessage(ChatID(update.message!.chat.id),
  //         "ldjmfiojediofjoewkne oewopfiewopi f poewinfo ");
  //   });
  // }

  // static connect1() async {
  //   //! Get the authenticated user's profile.
  //   final me = await twitter.tweets.countRecent(query: "");
  //   log(me.data.first.toString());
  //   //! Get the tweets associated with the search query.
  //   final tweets = await twitter.tweets.searchRecent(
  //     query: '#ElonMusk',
  //     maxResults: 20,
  //     // You can expand the search result.
  //     expansions: [
  //       v2.TweetExpansion.authorId,
  //       v2.TweetExpansion.inReplyToUserId,
  //     ],
  //     tweetFields: [
  //       v2.TweetField.conversationId,
  //       v2.TweetField.publicMetrics,
  //       v2.TweetField.editControls,
  //     ],
  //     userFields: [
  //       v2.UserField.location,
  //       v2.UserField.verified,
  //       v2.UserField.entities,
  //       v2.UserField.publicMetrics,
  //     ],

  //     //! Safe paging is easy to implement.
  //     paging: (event) {
  //       print(event.response);

  //       if (event.count == 3) {
  //         return v2.ForwardPaginationControl.stop();
  //       }

  //       return v2.ForwardPaginationControl.next();
  //     },
  //   );

  //   //! You can serialize & deserialize JSON from response object
  //   //! and model object.
  //   final tweetJson = tweets.data.first.toJson();
  //   final tweet = v2.TweetData.fromJson(tweetJson);
  //   print(tweet);
  // }
}
