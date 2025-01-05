class JournalingState {}

class JournalingInitial extends JournalingState {}

class JournalingLoading extends JournalingState {}

class JournalingLoaded extends JournalingState {
  final List<Map<String, dynamic>> journalEntries;
  final String motivationalMessage;

  JournalingLoaded(
      {required this.journalEntries, required String? motivationalMessage})
      : motivationalMessage =
            motivationalMessage ?? 'Stay positive and keep journaling!';
}

class JournalingError extends JournalingState {
  final String message;

  JournalingError({required this.message});
}
