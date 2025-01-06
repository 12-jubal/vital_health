import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/dashboard/dashboard_state.dart';
import 'package:vital_health/core/repositories/health_repository.dart';

class DashboardCubit extends Cubit<DashboardState> {
  HealthRepository repository;
  DashboardCubit(this.repository) : super(DashboardInitial());

  Future<void> fetchHealthData() async {
    try {
      emit(DashboardLoading());
      await Future.delayed(Duration(seconds: 2));
      final healthData = await repository.getHealthMetrics();
      // print(healthData);
      emit(DashboardLoaded(healthData: healthData));
    } catch (e) {
      emit(DashboardError(message: 'Failed to fetch health data.'));
    }
  }
}
