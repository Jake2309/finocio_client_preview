import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stockolio/bloc/news/news_bloc.dart';
import 'package:stockolio/di/service_injection.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/widgets/common/header.dart';

class SocialScreen extends StatefulWidget {
  SocialScreen({Key? key}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final String formattedDate = DateFormat('MMMMd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: SafeArea(
          child: Container(
            child: StandardHeader(
              title: 'Cộng đồng',
              subtitle: formattedDate,
              action: Container(),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<NewsBloc>(),
      ),
    );
  }
}
