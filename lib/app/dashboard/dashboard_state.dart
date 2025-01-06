class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Map<String, dynamic> healthData;

  DashboardLoaded({required this.healthData});
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError({required this.message});
}
