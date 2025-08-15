import 'package:codebase_assignment/core/utils/constants/app_constants.dart';
import 'package:codebase_assignment/core/widgets/connectivity_banner/cubit/connectivity_cubit.dart';
import 'package:codebase_assignment/core/widgets/connectivity_banner/cubit/connectivity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityDisconnected) {
          return _buildBanner(AppConstants.noInternetConnection, Colors.red);
        } else if (state is ConnectivityReconnected) {
          return _buildBanner(AppConstants.backOnline, Colors.green);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBanner(String message, Color color) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          color: color,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            message,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: const TextStyle(
              fontSize: 14, // Keep this reasonably small
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration: TextDecoration.none, // Removes underline
            ),
          ),
        ),
      ),
    );
  }
}
