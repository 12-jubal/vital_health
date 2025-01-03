class JournalingState {}

class JournalingInitial extends JournalingState {}

class JournalingLoading extends JournalingState {}

class JournalingLoaded extends JournalingState {
  final List<Map<String, dynamic>> journalEntries;

  JournalingLoaded({required this.journalEntries});
}

class JournalingError extends JournalingState {
  final String message;

  JournalingError({required this.message});
}
