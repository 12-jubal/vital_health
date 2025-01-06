import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/journaling/journaling_state.dart';
import 'package:vital_health/core/helpers/database_helper.dart';
import 'package:vital_health/core/repositories/motivational_message_repository.dart';

class JournalingCubit extends Cubit<JournalingState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  MotivationalMessageRepository motivationalMessageRepository;
  JournalingCubit(this.motivationalMessageRepository)
      : super(JournalingInitial());

  // Simulating a database or API interaction
  // final List<Map<String, dynamic>> _journalEntries = [];

  Future<void> fetchJournalsAndMotivationalMessage() async {
    try {
      emit(JournalingLoading());

      // Fetch journals from SQLite
      final journals = await _databaseHelper.fetchJournals();

      // Fetch motivational message
      final motivationalMessage =
          await motivationalMessageRepository.fetchRandomMessage();

      // await Future.delayed(Duration(seconds: 3));
      // print('loaded');
      emit(
        JournalingLoaded(
          journalEntries: journals,
          motivationalMessage: motivationalMessage,
        ),
      );
    } catch (e) {
      emit(JournalingError(
          message:
              'Failed to fetch journal entries and Motivational Message.'));
    }
  }

  Future<void> addJournalEntry(String mood, String content) async {
    try {
      final date = DateTime.now().toIso8601String();
      await _databaseHelper.addJournal(
          mood: mood, content: content, date: date);
      fetchJournalsAndMotivationalMessage(); // Refresh journals and motivational message
    } catch (e) {
      emit(JournalingError(message: e.toString()));
    }
  }
}
