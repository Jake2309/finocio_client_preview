import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/model/profile/stock_profile.dart';

// abstract class ProfileState extends Equatable {}

// class ProfileInitial extends ProfileState {
//   @override
//   List<Object> get props => [];
// }

// class ProfileFetchDataInprogress extends ProfileState {
//   @override
//   List<Object> get props => [];
// }

// class ProfileFetchDataSuccess extends ProfileState {
//   final StockProfile profileData;
//   final bool isSaved;
//   ProfileFetchDataSuccess({required this.profileData, required this.isSaved});
//   @override
//   List<Object> get props => [profileData, isSaved];
// }

// class ProfileFetchDataFailure extends ProfileState {
//   final String errMsg;
//   ProfileFetchDataFailure({required this.errMsg});
//   @override
//   List<Object> get props => [errMsg];
// }

class ProfileState {
  final String message;
  final StockProfile? profileData;
  final bool? isSaved;
  BlocStateStatus status;

  ProfileState(
      {this.message = '',
      this.status = BlocStateStatus.initial,
      this.profileData,
      this.isSaved});
}
