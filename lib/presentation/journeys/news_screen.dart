// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cryptoforecast/data/models/news_query_model.dart';
import 'package:cryptoforecast/di/get_it.dart';
import 'package:cryptoforecast/domain/entities/news_params.dart';
import 'package:cryptoforecast/presentation/blocs/news/news_cubit.dart';
import 'package:cryptoforecast/presentation/journeys/news_category.dart';
import 'package:cryptoforecast/presentation/journeys/news_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsCubit newsCubit;
  late NewsCubit latestNewsCubit;
  final CarouselController _controller = CarouselController();
  TextEditingController searchController = TextEditingController();
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newsModelListCarousel = <NewsQueryModel>[];
  List<String> navBarItem = [
    "Top News",
    "Bitcoin",
    "Ethereum",
    "DogeCoin",
    "Binance"
  ];

  @override
  void initState() {
    super.initState();
    newsCubit = getItInstance<NewsCubit>();
    latestNewsCubit = getItInstance<NewsCubit>();
    newsCubit.getNewsData("Cryptocurrency");
    latestNewsCubit.getNewsData("Bitcoin");
    Timer.periodic(
        const Duration(seconds: 300),
        (timer) =>
            newsCubit.getNews(const NewsParams(query: "Cryptocurrency")));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(
          create: (BuildContext context) => newsCubit,
        ),
        BlocProvider<NewsCubit>(
          create: (BuildContext context) => latestNewsCubit,
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //Search Wala Container
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if ((searchController.text).replaceAll(" ", "") == "") {
                        // print("Blank search");
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsCategory(
                                    query: searchController.text)));
                      }
                    },
                    child: Container(
                      child: const Icon(
                        Icons.search,
                        color: Colors.blueAccent,
                      ),
                      margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        if (value == "") {
                          // print("BLANK SEARCH");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsCategory(query: value)));
                          searchController.clear();
                        }
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Crypto News"),
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: navBarItem.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsCategory(query: navBarItem[index])));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(navBarItem[index],
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      );
                    })),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: BlocBuilder<NewsCubit, NewsState>(
                bloc: newsCubit,
                builder: (context, state) {
                  if (state is NewsError) {
                    return const Center(
                      child: Text(
                          'Data Currently Unavailable.. Please Try Later!'),
                    );
                  } else if (state is NewsLoaded) {
                    // print(state.news.first);
                    return CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: state.news.map((instance) {
                        return Builder(builder: (BuildContext context) {
                          try {
                            return Container(
                                child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewsView(url: instance.newsUrl)));
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          instance.newsImg,
                                          fit: BoxFit.fitHeight,
                                          width: double.infinity,
                                        )),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black12
                                                        .withOpacity(0),
                                                    Colors.black
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter)),
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    instance.newsHead,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                        )),
                                  ])),
                            ));
                          } catch (e) {
                            // print(e);
                            return Container(
                                child: const Center(
                              child: Text("News Currently UnAvailable",
                                  style: TextStyle(color: Colors.white)),
                            ));
                          }
                        });
                      }).toList(),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "LATEST NEWS ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<NewsCubit, NewsState>(
                    bloc: latestNewsCubit,
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
                              try {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NewsView(
                                                  url: state
                                                      .news[index].newsUrl)));
                                    },
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
                                                            BorderRadius
                                                                .circular(15),
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              Colors.black12
                                                                  .withOpacity(
                                                                      0),
                                                              Colors.black
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter)),
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        15, 15, 10, 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state.news[index]
                                                              .newsHead,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          state
                                                                      .news[
                                                                          index]
                                                                      .newsDes
                                                                      .length >
                                                                  50
                                                              ? "${state.news[index].newsDes.substring(0, 55)}...."
                                                              : state
                                                                  .news[index]
                                                                  .newsDes,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    )))
                                          ],
                                        )),
                                  ),
                                );
                              } catch (e) {
                                // print(e);
                                return Container();
                              }
                            });
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NewsCategory(query: "Crypto")));
                            },
                            child: const Text("SHOW MORE")),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
