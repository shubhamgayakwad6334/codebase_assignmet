import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../auth/presentation/cubit/local/local_user_cubit.dart';
import '../../../auth/presentation/cubit/local/local_user_state.dart';

class UserHeadingWidget extends StatelessWidget {
  const UserHeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalUserCubit, LocalUserState>(
      builder: (BuildContext context, state) {
        if (state is LocalUserLoading) {
          return CircularProgressIndicator();
        } else if (state is LocalUserSuccessState) {
          return Row(
            children: [
              Text("${AppConstants.welcome}, ", style: TextStyle(color: Colors.black, fontSize: 18)),
              Text(
                Utils.extractName(state.userDetails.email),
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          );
        }
        return Text(AppConstants.welcome, style: TextStyle(color: Colors.white));
      },
    );
  }
}
