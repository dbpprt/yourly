import 'package:flutter/material.dart';
import 'package:yourly/bloc/article_bloc.dart';
import 'package:yourly/bloc/article_event.dart';
import 'package:yourly/bloc/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourly/components/components.dart';
import 'package:yourly/providers/provider_registry.dart';

class GenericArticlePage extends StatefulWidget {
  final String articleProviderName;

  GenericArticlePage({@required this.articleProviderName});

  @override
  State<StatefulWidget> createState() {
    return _GenericArticlePageState(articleProviderName: articleProviderName);
  }
}

class _GenericArticlePageState extends State<GenericArticlePage> {
  _GenericArticlePageState({this.articleProviderName}) {
    _scrollController.addListener(_onScroll);
  }

  String articleProviderName;

  ArticleBloc _articleBloc;
  Provider _provider;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void dispose() {
    _articleBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    (() async {
      final provider = await ProviderRegistry.get.resolve(articleProviderName);
      _articleBloc =
          ArticleBloc(articleFetcher: provider.api.fetch, articlesPerPage: 25);

      _articleBloc.dispatch(Fetch());

      setState(() {
        _provider = provider;
      });
    })();
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(milliseconds: 500));
    _articleBloc.dispatch(Reset());
    await new Future.delayed(new Duration(milliseconds: 500));
    _articleBloc.dispatch(Fetch());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _articleBloc.dispatch(Fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      return Container();
    }

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
                      : _provider.api.render(context, state.articles[index]);
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
}
