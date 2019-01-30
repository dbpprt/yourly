import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:yourly/bloc/article_event.dart';
import 'package:yourly/bloc/article_state.dart';

typedef Future<List<dynamic>> ArticleFetcher(int page);

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleFetcher articleFetcher;
  final int articlesPerPage;

  ArticleBloc({@required this.articleFetcher, @required this.articlesPerPage});

  @override
  Stream<ArticleEvent> transform(Stream<ArticleEvent> events) {
    return (events as Observable<ArticleEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => ArticleUninitialized();

  @override
  Stream<ArticleState> mapEventToState(currentState, event) async* {
    if (event is Reset) {
      currentState = ArticleUninitialized();
      yield ArticleUninitialized();
    }

    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ArticleUninitialized) {
          final posts = await articleFetcher(1);
          yield ArticleLoaded(articles: posts, hasReachedMax: false);
        }
        if (currentState is ArticleLoaded) {
          if (currentState.articles.length < articlesPerPage) {
            yield currentState.copyWith(hasReachedMax: true);
            return;
          }

          var page = currentState.articles.length ~/ articlesPerPage + 1;

          final posts = await articleFetcher(page);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ArticleLoaded(
                  articles: currentState.articles + posts,
                  hasReachedMax: posts.length < articlesPerPage,
                );
        }
      } catch (_) {
        yield ArticleError();
      }
    }
  }

  bool _hasReachedMax(ArticleState state) =>
      state is ArticleLoaded && state.hasReachedMax;
}
