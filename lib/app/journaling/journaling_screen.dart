import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/journaling/journaling_cubit.dart';
import 'package:vital_health/app/journaling/journaling_state.dart';
import 'package:vital_health/core/repositories/motivational_message_repository.dart';
import 'package:vital_health/utils/widgets/add_journal.dart';

class JournalingScreen extends StatelessWidget {
  const JournalingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JournalingCubit(MotivationalMessageRepository())
        ..fetchJournalsAndMotivationalMessage(), // Fetch entries on load
      child: BlocConsumer<JournalingCubit, JournalingState>(
        listener: (context, state) {
          if (state is JournalingError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          // final cubit = context.read<JournalingCubit>();

          return Scaffold(
            appBar: AppBar(title: Text('My Journal')),
            body: Builder(
              builder: (context) {
                if (state is JournalingLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is JournalingError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is JournalingLoaded) {
                  // final entries = state.journalEntries;
                  final journals = state.journalEntries;
                  final motivationalMessage = state.motivationalMessage;

                  if (journals.isEmpty) {
                    return Center(
                      child: Text(
                        'No journal entries yet. \n Please add a new entry.',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return Column(
                    children: [
                      // Display motivational message
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          motivationalMessage,
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: journals.length,
                          itemBuilder: (context, index) {
                            final entry = journals[index];
                            return ListTile(
                              leading: Text(entry['mood'],
                                  style: TextStyle(fontSize: 24)),
                              title: Text(entry['content']),
                              subtitle: Text(entry['date']),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text('Welcome to Journaling!'));
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showAddJournalBottomSheet(
                  context,
                  (mood, content) {
                    context
                        .read<JournalingCubit>()
                        .addJournalEntry(mood, content);
                  },
                );
              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _showAddJournalBottomSheet(
      BuildContext context, Function(String mood, String content) saveEntry) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AddJournalBottomSheet(onSave: saveEntry);
      },
    );
  }
}
