import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_search_sample/src/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc extends Bloc<SearchMovieEvent, List<String>> {
  final MovieRepository _movieRepository;
  MovieBloc(this._movieRepository) : super([]) {
    on<BtnSearchMovieEvent>((event, emit) async {
      var result = await _movieRepository.search('개들의 전쟁');
      emit(result);
    });
    on<SearchMovieEvent>((event, emit) async {
      var result = await _movieRepository.search(event.key);
      emit(result);
    },
        transformer: (events, mapper) =>
            events.debounceTime(const Duration(microseconds: 1000)));
  }

  // @override
  // void onChange(Change<List<String>> change) {
  //   super.onChange(change);
  // }

  @override
  void onTransition(Transition<SearchMovieEvent, List<String>> transition) {
    super.onTransition(transition);
    print(transition);
  }
}

class SearchMovieEvent extends Equatable {
  final String key;
  const SearchMovieEvent(this.key);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class BtnSearchMovieEvent extends SearchMovieEvent {
  const BtnSearchMovieEvent() : super('');
}
