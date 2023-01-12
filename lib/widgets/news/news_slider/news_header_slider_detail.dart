import 'package:flutter/material.dart';
import 'package:stockolio/model/news/news.dart';

class HeaderSliderDetail extends StatefulWidget {
  News? item;

  HeaderSliderDetail({Key? key, this.item}) : super(key: key);

  _HeaderSliderDetailState createState() => _HeaderSliderDetailState(item);
}

class _HeaderSliderDetailState extends State<HeaderSliderDetail> {
  News? item;
  _HeaderSliderDetailState(this.item);

  @override
  Widget build(BuildContext context) {
    double _fullHeight = MediaQuery.of(context).size.height;

    /// Hero animation for image
    final hero = Hero(
      tag: 'hero-tag-${item!.id}',
      child: new DecoratedBox(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new AssetImage(item!.imageUrl!),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Container(
          margin: EdgeInsets.only(top: 130.0),
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
        ),
      ),
    );

    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                  expandedHeight: _height - 30.0,
                  img: item!.imageUrl,
                  id: item!.id.toString(),
                  title: item!.title,
                  category: item!.category),
              pinned: true,
            ),

            /// Appbar Custom using a SliverAppBar
            // SliverAppBar(
            //   centerTitle: true,
            //   backgroundColor: Color(0xFF172E4D),
            //   iconTheme: IconThemeData(color: Colors.white),
            //   expandedHeight: _fullHeight - 20,
            //   elevation: 0.1,
            //   pinned: true,
            //   flexibleSpace: FlexibleSpaceBar(
            //       centerTitle: true,
            //       title: Container(
            //         width: 220.0,
            //         child: Padding(
            //           padding: const EdgeInsets.only(top: 50.0),
            //           child: Text(
            //             item.title,
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 16.5,
            //                 fontFamily: "Popins",
            //                 fontWeight: FontWeight.w700),
            //             maxLines: 3,
            //             overflow: TextOverflow.ellipsis,
            //           ),
            //         ),
            //       ),
            //       background: Stack(
            //         children: <Widget>[
            //           Material(
            //             child: hero,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 540.0, left: 20.0),
            //             child: Text(
            //               item.category,
            //               style: TextStyle(
            //                   color: Colors.white54,
            //                   fontSize: 16.0,
            //                   fontFamily: "Popins",
            //                   fontWeight: FontWeight.w400),
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //           )
            //         ],
            //       )),
            // ),

            SliverToBoxAdapter(
                child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: Text(
                  item!.descriptions!,
                  style: TextStyle(
                      fontFamily: "Popins",
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: Text(
                  item!.descriptions!,
                  style: TextStyle(
                      fontFamily: "Popins",
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: Text(
                  item!.descriptions!,
                  style: TextStyle(
                      fontFamily: "Popins",
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 50.0,
              )
            ])),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String? img, id, title, category;

  MySliverAppBar(
      {required this.expandedHeight,
      this.img,
      this.id,
      this.title,
      this.category});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Color(0xFF172E4D),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            transitionOnUserGestures: true,
            tag: 'hero-tag-${id}',
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage(img!),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 130.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: <Color>[
                      const Color(0xFF000000),
                      const Color(0x00000000),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        //  Positioned(
        //     top: expandedHeight / 2 - shrinkOffset,
        //     left: MediaQuery.of(context).size.width / 4,
        //     child: Opacity(
        //       opacity: (1 - shrinkOffset / expandedHeight),
        //       child: Card(
        //         elevation: 10,
        //         child: SizedBox(
        //           height: expandedHeight,
        //           width: MediaQuery.of(context).size.width / 2,
        //           child: Container(
        //               width: 220.0,
        //               child: Padding(
        //                 padding: const EdgeInsets.only(top: 50.0),
        //                 child: Text(
        //                   title,
        //                   style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 16.5,
        //                       fontFamily: "Popins",
        //                       fontWeight: FontWeight.w700),
        //                   maxLines: 3,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //         ),
        //       ),
        //     ),),),

        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Text(
                      title!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.5,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w700),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    child: Text(
                      category!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.5,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w400),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Icon(Icons.arrow_back),
                    ))),
            Align(
              alignment: Alignment.center,
              child: Text(
                "News",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Gotik",
                  fontWeight: FontWeight.w700,
                  fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
                ),
              ),
            ),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
