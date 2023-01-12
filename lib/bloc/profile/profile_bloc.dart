import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockolio/bloc/profile/profile_event.dart';
import 'package:stockolio/bloc/profile/profile_state.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/repository/profile_repository/profile_repo.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(ProfileState()) {
    on<ProfileStarted>(
        (event, emit) => emit(ProfileState(status: BlocStateStatus.loading)));
    on<ProfileFetchData>((event, emit) => _onFetchProfileData(event, emit));
  }

  void _onFetchProfileData(
      ProfileFetchData event, Emitter<ProfileState> emit) async {
    var data = await profileRepository.getSymbolInfo(event.symbol);

    if (data != null)
      emit(ProfileState(
          profileData: data, isSaved: true, status: BlocStateStatus.success));
    else
      emit(ProfileState(
          message: 'Get symbol error', status: BlocStateStatus.failure));
  }
}
