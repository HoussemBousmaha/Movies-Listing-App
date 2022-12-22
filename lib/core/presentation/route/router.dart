import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app_okoul/features/movie/presentation/view/movie_search_sheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/favorite/presentation/view/favorite_movies.dart';
import '../../../features/movie/presentation/constant/movies_enum.dart';
import '../../../features/movie/presentation/view/all_movies.dart';
import '../../../features/movie/presentation/view/movie.dart';
import '../../../features/movie/presentation/view/movie_details.dart';
import '../../../features/movie/presentation/view/movie_search.dart';
import '../resource/app_route_const.dart';
import '../view/navigation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutePath.movie,
    routes: [
      ShellRoute(
        builder: (context, state, child) => NavigationView(key: state.pageKey, child: child),
        routes: [
          GoRoute(
            path: AppRoutePath.movie,
            name: AppRouteName.movie,
            pageBuilder: (context, state) => FadeTransitionPage(key: state.pageKey, child: MoviesView(key: state.pageKey)),
            routes: [
              GoRoute(
                path: AppRoutePath.allMovies,
                name: AppRouteName.allMovies,
                pageBuilder: (context, state) {
                  final typeName = state.params['type'] as String;
                  final type = MoviesType.values.firstWhere((type) => type.name == typeName, orElse: () => MoviesType.upcoming);

                  return FadeTransitionPage(key: state.pageKey, child: AllMoviesView(key: state.pageKey, type: type));
                },
              ),
              GoRoute(
                path: AppRoutePath.movieDetails,
                name: AppRouteName.movieDetails,
                pageBuilder: (context, state) {
                  final id = int.parse(state.params['id'] as String);

                  return FadeTransitionPage(key: state.pageKey, child: MovieDetailsView(key: state.pageKey, id: id));
                },
              ),
              GoRoute(
                path: AppRoutePath.searchSheet,
                name: AppRouteName.searchSheet,
                pageBuilder: (context, state) => SlideTransitionPage(key: state.pageKey, child: MovieSearchSheet(key: state.pageKey)),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutePath.search,
            name: AppRouteName.search,
            pageBuilder: (context, state) => FadeTransitionPage(key: state.pageKey, child: MovieSearchView(key: state.pageKey)),
          ),
          GoRoute(
            path: AppRoutePath.favorite,
            name: AppRouteName.favorite,
            pageBuilder: (context, state) => FadeTransitionPage(key: state.pageKey, child: FavoriteMoviesView(key: state.pageKey)),
          ),
        ],
      ),
    ],
  );
}

class FadeTransitionPage extends CustomTransitionPage {
  const FadeTransitionPage({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
          key: key,
          child: child,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: const Duration(milliseconds: 400),
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);
}

class SlideTransitionPage extends CustomTransitionPage {
  const SlideTransitionPage({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
          key: key,
          child: child,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: const Duration(milliseconds: 500),
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeInQuart)),
        child: child,
      );
}

class SlideRightTransitionPage extends CustomTransitionPage {
  const SlideRightTransitionPage({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
          key: key,
          child: child,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: const Duration(milliseconds: 300),
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeInQuart)),
        child: child,
      );
}

class SlideLeftTransitionPage extends CustomTransitionPage {
  const SlideLeftTransitionPage({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
          key: key,
          child: child,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: const Duration(milliseconds: 300),
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeInQuart)),
        child: child,
      );
}
