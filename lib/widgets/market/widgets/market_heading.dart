import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stockolio/widgets/common/header.dart';

class MarketHeadingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMMd').format(DateTime.now());

    return StandardHeader(
      title: 'Thị trường',
      subtitle: formattedDate,
      action: GestureDetector(
          child: Icon(FontAwesomeIcons.search),
          onTap: () => Navigator.pushNamed(context, '/about')),
    );
  }
}
