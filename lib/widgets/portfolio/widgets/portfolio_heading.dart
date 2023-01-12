import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:stockolio/widgets/common/header.dart';

// Header screen watchlist
class PortfolioHeadingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMMd').format(DateTime.now());
    final String portfolioTitle = 'Danh mục';

    return StandardHeader(
      title: portfolioTitle,
      subtitle: formattedDate,
      action: GestureDetector(
        child: Icon(
          FontAwesomeIcons.user,
          size: 20,
        ),
        onTap: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Tên danh mục'),
            content: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text('OK'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Cancel'),
              ),
            ],
          ),
          barrierDismissible: true,
        ),
      ),
    );
  }
}
