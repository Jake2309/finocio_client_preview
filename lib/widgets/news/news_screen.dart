import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stockolio/bloc/news/news_bloc.dart';
import 'package:stockolio/bloc/news/news_common.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/di/service_injection.dart';
import 'package:stockolio/model/news/news.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/widgets/common/header.dart';
import 'package:stockolio/widgets/news/news_list_detail.dart';
import 'package:stockolio/widgets/news/news_slider/intro_page_item.dart';
import 'package:stockolio/widgets/news/news_slider/page_transformer.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String formattedDate = DateFormat('MMMMd').format(DateTime.now());

  ///
  /// Get image data dummy from firebase server
  ///
  var imageNetwork = NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Artboard%203.png?alt=media&token=dc7f4bf5-8f80-4f38-bb63-87aed9d59b95");

  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;
  late List<News> _newsItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: SafeArea(
          child: Container(
            child: StandardHeader(
              title: 'Tin tức',
              subtitle: formattedDate,
              action: Container(),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<NewsBloc>(),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state.status == BlocStateStatus.initial) {
              BlocProvider.of<NewsBloc>(context)
                  .add(FetchNewsData(symbols: []));
            }

            if (state.status == BlocStateStatus.success) {
              _newsItem = state.data!.results!;
              return SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    ClipPath(
                        clipper: new DialogonalClipper(),
                        child: Container(
                          height: 230.0,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  tileMode: TileMode.repeated,
                                  colors: [
                                Color(0xFF15EDED),
                                Color(0xFF029CF5)
                              ])),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 70.0, left: 20.0),
                          child: Text(
                            "Today",
                            style: TextStyle(
                                fontFamily: "Sans",
                                fontWeight: FontWeight.w800,
                                fontSize: 30.0,
                                letterSpacing: 1.5,
                                color: Colors.white),
                          ),
                        ),
                        loadImage
                            ? _loadingDataList(context)
                            : _dataLoadedList(context),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  ///
  ///
  /// Calling imageLoading animation for set a grid layout
  ///
  ///
  Widget _loadingDataHeader(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.fromHeight(500.0),
      child: PageTransformer(
        pageViewBuilder: (context, visibilityResolver) {
          return PageView.builder(
            controller: PageController(viewportFraction: 0.87),
            itemCount: _newsItem != null ? _newsItem.length : 0,
            itemBuilder: (context, index) {
              final item = _newsItem[index];
              final pageVisibility =
                  visibilityResolver.resolvePageVisibility(index);
              return cardHeaderLoading(context);
            },
          );
        },
      ),
    );
  }

  Widget cardHeaderLoading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 500.0,
        width: 275.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color(0xFF2C3B4F),
        ),
        child: Shimmer.fromColors(
          baseColor: Color(0xFF3B4659),
          highlightColor: Color(0xFF606B78),
          child: Padding(
            padding: const EdgeInsets.only(top: 320.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 17.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  height: 20.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 20.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 20.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///
  /// Calling ImageLoaded animation for set a grid layout
  ///
  ///
  Widget _dataLoadedHeader(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.fromHeight(500.0),
      child: PageTransformer(
        pageViewBuilder: (context, visibilityResolver) {
          return PageView.builder(
            controller: PageController(viewportFraction: 0.87),
            itemCount: _newsItem.length,
            itemBuilder: (context, index) {
              final item = _newsItem[index];
              final pageVisibility =
                  visibilityResolver.resolvePageVisibility(index);
              return IntroPageItem(
                item: item,
                pageVisibility: pageVisibility,
              );
            },
          );
        },
      ),
    );
  }

  ///
  ///
  /// Calling imageLoading animation for set a list layout
  ///
  ///
  Widget _loadingDataList(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(top: 0.0),
        itemCount: _newsItem.length,
        itemBuilder: (ctx, i) {
          return loadingCard(ctx, _newsItem[i]);
        },
      ),
    );
  }

  Widget loadingCard(BuildContext ctx, News item) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 20.0, bottom: 0.0),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF3B4659),
        highlightColor: Color(0xFF606B78),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 95.0,
              width: 130.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Theme.of(ctx).hintColor.withAlpha(170),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 13.0,
                      width: 70.0,
                      color: Theme.of(ctx).hintColor.withAlpha(170),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Container(
                      height: 15.0,
                      width: 170.0,
                      color: Theme.of(ctx).hintColor.withAlpha(170),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Container(
                      height: 15.0,
                      width: 170.0,
                      color: Theme.of(ctx).hintColor.withAlpha(170),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 15.0,
                          color: Theme.of(ctx).hintColor.withAlpha(170),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Container(
                            height: 12.0,
                            width: 30.0,
                            color: Theme.of(ctx).hintColor.withAlpha(170),
                          ),
                        )
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

  ///
  ///
  /// Calling ImageLoaded animation for set a grid layout
  ///
  ///
  Widget _dataLoadedList(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(top: 0.0),
        itemCount: _newsItem.length,
        itemBuilder: (ctx, i) {
          return card(_newsItem[i], ctx);
        },
      ),
    );
  }

  Widget card(News item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 20.0, bottom: 0.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => new NewsListDetail(
                      item: item,
                    ),
                transitionDuration: Duration(milliseconds: 600),
                transitionsBuilder:
                    (_, Animation<double> animation, __, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: child,
                  );
                }),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'hero-tag-list-${item.id}',
              child: Material(
                child: Container(
                  height: 95.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    image: DecorationImage(
                        image: AssetImage(
                          item.imageUrl!,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      item.creator!,
                      style: TextStyle(
                          fontFamily: "Gotik",
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!
                              .withOpacity(0.3)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Container(
                        width: 180.0,
                        child: Text(
                          item.title!,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 15.0,
                          color: Theme.of(context).hintColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            item.pubDate.toString(),
                            style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontFamily: "Gotik"),
                          ),
                        )
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

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path = Path();
    path.lineTo(0.0, size.height * 1.5);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    paint.color = Color(0xFF15EDED);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 180.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
