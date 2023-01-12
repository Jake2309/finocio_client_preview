import 'package:flutter/material.dart';
import 'package:stockolio/model/news/news.dart';
import 'package:stockolio/widgets/news/news_slider/news_header_slider_detail.dart';
import 'package:stockolio/widgets/news/news_slider/page_transformer.dart';

class IntroPageItem extends StatelessWidget {
  IntroPageItem({
    required this.item,
    required this.pageVisibility,
  });

  final News item;
  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    required double translationFactor,
    required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        item.category!,
        style: textTheme.caption!.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          item.title!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var image = Image.asset(
      item.imageUrl!,
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
    );

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Hero(
        tag: 'hero-tag-${item.id}',
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                image: AssetImage(item.imageUrl!),
                fit: BoxFit.cover,
                alignment: FractionalOffset(
                  0.5 + (pageVisibility.pagePosition / 3),
                  0.5,
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [
                    const Color(0xFF000000),
                    const Color(0x00000000),
                  ],
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new HeaderSliderDetail(
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
                child: Stack(
                  children: <Widget>[
                    // image,
                    imageOverlayGradient,
                    _buildTextContainer(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // return Material(
    //   elevation: 4.0,
    //   borderRadius: BorderRadius.circular(20.0),
    //   child: Stack(
    //     fit: StackFit.expand,
    //     children: [
    //       image,
    //       imageOverlayGradient,
    //       _buildTextContainer(context),
    //     ],
    //   ),
    // );
  }
}
