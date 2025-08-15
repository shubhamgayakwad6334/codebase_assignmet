import 'package:codebase_assignment/core/utils/constants/app_constants.dart';
import 'package:codebase_assignment/features/auth/data/data_source/mappers/user_data_mapper.dart';
import 'package:codebase_assignment/features/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/sharedpref_helper.dart';
import 'local_user_state.dart';

class LocalUserCubit extends Cubit<LocalUserState> {
  LocalUserCubit() : super(LocalUserInitial());

  Future<void> fetchUserDataFromLocal() async {
    emit(LocalUserLoading());
    try {
      // Fetch user data
      final UserModel? user = await SharedPrefHelper.getUserDetails();

      if (user != null) {
        emit(LocalUserSuccessState(userDetails: user.toEntity()));
      } else {
        emit(LocalUserErrorState(AppConstants.somethingWentWrong));
      }
    } catch (e) {
      emit(LocalUserErrorState(AppConstants.somethingWentWrong));
    }
  }
}
