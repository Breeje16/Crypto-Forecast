import 'package:bloc/bloc.dart';
import 'package:cryptoforecast/data/models/news_query_model.dart';
import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/entities/news_params.dart';
import 'package:cryptoforecast/domain/usecases/get_news.dart';
import 'package:cryptoforecast/presentation/blocs/loading/loading_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNews getNews;
  final LoadingCubit loadingCubit;

  NewsCubit({
    required this.getNews,
    required this.loadingCubit,
  }) : super(NewsInitial());

  Future<void> getNewsData(String query) async {
    loadingCubit.show();
    emit(NewsLoading());
    final Either<AppError, List<NewsQueryModel>> response =
        await getNews(NewsParams(query: query));
    emit(response.fold(
      (l) => NewsError(l),
      (r) => NewsLoaded(r),
    ));
    loadingCubit.hide();
  }
}
