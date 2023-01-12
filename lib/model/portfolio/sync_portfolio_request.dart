// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SyncPortfolioRequest extends Equatable {
  final String uid;
  final String oldIdentification;

  SyncPortfolioRequest({
    required this.uid,
    required this.oldIdentification,
  });

  Map<String, String> toJson() => {
        'uid': uid,
        'oldIdentification': oldIdentification,
      };

  @override
  List<Object> get props => [uid, oldIdentification];
}
