import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/journaling/journaling_state.dart';

class JournalingCubit extends Cubit<JournalingState> {
  JournalingCubit() : super(JournalingInitial());

  // Simulating a database or API interaction
  final List<Map<String, dynamic>> _journalEntries = [];

  Future<void> fetchJournalEntries() async {
    try {
      emit(JournalingLoading());
      await Future.delayed(Duration(seconds: 3));
      emit(JournalingLoaded(journalEntries: _journalEntries));
    } catch (e) {
      emit(JournalingError(message: 'Failed to fetch journal entries.'));
    }
  }

  Future<void> addJournalEntry(String mood, String content) async {
    try {
      emit(JournalingLoading());
      await Future.delayed(Duration(seconds: 3));
      final entry = {
        'mood': mood,
        'content': content,
        'timestamp': DateTime.now().toIso8601String(),
      };
      _journalEntries.add(entry);
      emit(JournalingLoaded(journalEntries: _journalEntries));
    } catch (e) {
      emit(JournalingError(message: 'Failed to save the journal entry.'));
    }
  }
}
