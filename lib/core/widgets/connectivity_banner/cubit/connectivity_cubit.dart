import 'dart:async';
import 'package:codebase_assignment/core/widgets/connectivity_banner/cubit/connectivity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/network_connectivity/network_connectivity.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final NetworkConnectivityService networkConnectivity;
  StreamSubscription<bool>? _subscription;

  bool isConnected = true;

  ConnectivityCubit({
    required this.networkConnectivity,
  }) : super(ConnectivityIdle()) {
    _init();
  }

  Future<void> _init() async {
    _subscription =
        networkConnectivity.connectionStream.listen(_onConnectivityChanged);
  }

  void _onConnectivityChanged(bool result) async {
    if (!result && isConnected) {
      isConnected = result;
      emit(ConnectivityDisconnected());
    } else if (result && !isConnected) {
      isConnected = true;
      emit(ConnectivityReconnected());
      await Future.delayed(const Duration(seconds: 5));
      emit(ConnectivityIdle());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    networkConnectivity.dispose();
    return super.close();
  }
}
