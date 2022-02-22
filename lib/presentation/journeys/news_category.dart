import 'package:cryptoforecast/di/get_it.dart';
import 'package:cryptoforecast/presentation/blocs/news/news_cubit.dart';
import 'package:cryptoforecast/presentation/journeys/news_view.dart';
import 'package:cryptoforecast/presentation/themes/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCategory extends StatefulWidget {
  final String query;
  const NewsCategory({Key? key, required this.query}) : super(key: key);

  @override
  _NewsCategoryState createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {
  late NewsCubit categoryNewsCubit;

  @override
  void initState() {
    super.initState();
    categoryNewsCubit = getItInstance<NewsCubit>();
    String q = widget.query;
    categoryNewsCubit.getNewsData(q);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CF NEWS"),
        backgroundColor: Colorz.currenciesPageBackground,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => categoryNewsCubit,
        child: SingleChildScrollView(
          child: Container(
            color: Colorz.currenciesPageBackground,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          widget.query.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 28, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<NewsCubit, NewsState>(
                  bloc: categoryNewsCubit,
                  builder: (context, state) {
                    if (state is NewsError) {
                      return const Center(
                        child: Text(
                            'Data Currently Unavailable.. Please Try Later!'),
                      );
                    } else if (state is NewsLoaded) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.news.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsView(
                                            url: state.news[index].newsUrl)));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 1.0,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              state.news[index].newsImg,
                                              fit: BoxFit.fitHeight,
                                              height: 230,
                                              width: double.infinity,
                                            )),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black12
                                                              .withOpacity(0),
                                                          Colors.black
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter)),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 15, 10, 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state
                                                          .news[index].newsHead,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      state.news[index].newsDes
                                                                  .length >
                                                              50
                                                          ? "${state.news[index].newsDes.substring(0, 55)}...."
                                                          : state.news[index]
                                                              .newsDes,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )))
                                      ],
                                    )),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('Try Later!'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
