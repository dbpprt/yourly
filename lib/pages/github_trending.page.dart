import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yourly/bloc/article_bloc.dart';
import 'package:yourly/bloc/article_event.dart';
import 'package:yourly/bloc/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:yourly/components/bottomloader.component.dart';
import 'package:yourly/components/github_trending_article.component.dart';
import 'package:yourly/models/github_trending_article.dart' as model;

class GithubTrendingPage extends StatefulWidget {
  final String language;

  GithubTrendingPage({this.language});

  @override
  State<StatefulWidget> createState() {
    return _GithubTrendingPageState(language: language);
  }
}

class _GithubTrendingPageState extends State<GithubTrendingPage> {
  static final http.Client httpClient = http.Client();
  final _scrollController = ScrollController();
  ArticleBloc _articleBloc;
  final _scrollThreshold = 200.0;
  final String language;

  _GithubTrendingPageState({this.language}) {
    _scrollController.addListener(_onScroll);

    _articleBloc =
        ArticleBloc(articleFetcher: _fetchArticles, articlesPerPage: 25);
    _articleBloc.dispatch(Fetch());
  }

  Future<List<dynamic>> _fetchArticles(int page) async {
    if (page != 1) {
      return List<dynamic>();
    }

    var url = 'https://github-trending-api.now.sh/repositories';

    if (language != null) {
      url += '?language=' + language;
    }

    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data;
    } else {
      throw Exception('error fetching articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new RefreshIndicator(
        backgroundColor: Colors.white70,
        child: BlocBuilder(
          bloc: _articleBloc,
          builder: (BuildContext context, ArticleState state) {
            if (state is ArticleUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ArticleError) {
              return Center(
                child: Text('failed to fetch articles'),
              );
            }
            if (state is ArticleLoaded) {
              if (state.articles.isEmpty) {
                return Center(
                  child: Text('no posts'),
                );
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.articles.length
                      ? BottomLoader()
                      : GithubTrendingArticle(
                          post: model.GithubTrendingArticle.fromRawObject(
                              state.articles[index]));
                },
                itemCount: state.hasReachedMax
                    ? state.articles.length
                    : state.articles.length + 1,
                controller: _scrollController,
              );
            }
          },
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(milliseconds: 500));
    _articleBloc.dispatch(Reset());
    await new Future.delayed(new Duration(milliseconds: 500));
    _articleBloc.dispatch(Fetch());
  }

  @override
  void dispose() {
    _articleBloc.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _articleBloc.dispatch(Fetch());
    }
  }
}
