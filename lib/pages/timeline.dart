// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:yourly/bloc/article_bloc.dart';
// import 'package:yourly/bloc/article_event.dart';
// import 'package:yourly/bloc/article_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yourly/database/common/database_provider.dart';
// import 'package:yourly/database/entities/saved_article.dart';
// import 'package:yourly/database/saved_article_database_repository.dart';
// import 'package:yourly/models/github_trending_article.dart' as model;
// import 'package:yourly/models/hacker_news_article.dart' as model;
// import 'package:rounded_modal/rounded_modal.dart';

// class TimelinePage extends StatefulWidget {
//   TimelinePage();

//   @override
//   State<StatefulWidget> createState() {
//     return _TimelinePageState();
//   }
// }

// class _TimelinePageState extends State<TimelinePage> {
//   static final http.Client httpClient = http.Client();
//   final _scrollController = ScrollController();
//   ArticleBloc _articleBloc;
//   final _scrollThreshold = 200.0;
//   int articleCount = 0;

//   _TimelinePageState() {
//     _scrollController.addListener(_onScroll);

//     _articleBloc =
//         ArticleBloc(articleFetcher: _fetchArticles, articlesPerPage: 25);
//     _articleBloc.dispatch(Fetch());
//   }

//   Future<List<dynamic>> _fetchArticles(int page) async {

//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new RefreshIndicator(
//         backgroundColor: Colors.white70,
//         child: BlocBuilder(
//           bloc: _articleBloc,
//           builder: (BuildContext context, ArticleState state) {
//             if (state is ArticleUninitialized) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (state is ArticleError) {
//               return Center(
//                 child: Text('failed to fetch articles'),
//               );
//             }
//             if (state is ArticleLoaded) {
//               if (state.articles.isEmpty) {
//                 return Center(
//                   child: Text('no posts'),
//                 );
//               }
//               return ListView.builder(
//                 itemBuilder: (BuildContext context, int index) {
//                   articleCount = state.articles.length;

//                   if (index >= state.articles.length) {
//                     if (articleCount < 5) {
//                       return null;
//                     }
//                     return BottomLoader();
//                   }

//                   var item = state.articles[index] as SavedArticle;

//                   switch (item.type) {
//                     case "hackernews":
//                       return HackerNewsArticle(
//                           onDoubleTap: () async {
//                             HapticFeedback.vibrate();
//                             showRoundedModalBottomSheet(
//                                 context: context,
//                                 radius: 10.0, // This is the default
//                                 color: Colors.black87,
//                                 // color: Colors.grey.shade50, // Also default
//                                 builder: (context) {
//                                   return TimelineActionsheet(
//                                     id: item.id,
//                                     url: item.url,
//                                     onDelete: _handleRefresh,
//                                   );
//                                 });
//                           },
//                           post: model.HackerNewsArticle.fromRawObject(
//                               json.decode(item.data)));

//                     case "github":
//                       return GithubTrendingArticle(
//                           onDoubleTap: () async {
//                             HapticFeedback.vibrate();
//                             showRoundedModalBottomSheet(
//                                 context: context,
//                                 radius: 10.0, // This is the default
//                                 color: Colors.black87,
//                                 // color: Colors.grey.shade50, // Also default
//                                 builder: (context) {
//                                   return TimelineActionsheet(
//                                     id: item.id,
//                                     url: item.url,
//                                     onDelete: _handleRefresh,
//                                   );
//                                 });
//                           },
//                           post: model.GithubTrendingArticle.fromRawObject(
//                               json.decode(item.data)));
//                   }
//                 },
//                 itemCount: state.hasReachedMax
//                     ? state.articles.length
//                     : state.articles.length + 1,
//                 controller: _scrollController,
//               );
//             }
//           },
//         ),
//         onRefresh: _handleRefresh,
//       ),
//     );
//   }

//   Future<Null> _handleRefresh() async {
//     await new Future.delayed(new Duration(milliseconds: 500));
//     _articleBloc.dispatch(Reset());
//     await new Future.delayed(new Duration(milliseconds: 500));
//     _articleBloc.dispatch(Fetch());
//   }

//   @override
//   void dispose() {
//     _articleBloc.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.position.pixels;
//     if (maxScroll - currentScroll <= _scrollThreshold && articleCount > 4) {
//       _articleBloc.dispatch(Fetch());
//     }
//   }

//   refresh() {}
// }
