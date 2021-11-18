import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies_state.dart';

class MoviesBloc extends Cubit<MoviesState> {
  bool rememberSession;

  MoviesBloc({
    this.rememberSession = true,
  }) : super(UnknownState());
}
