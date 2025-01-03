import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vital_health/app/journaling/journaling_cubit.dart';
import 'package:vital_health/app/journaling/journaling_state.dart';

class JournalingScreen extends StatelessWidget {
  const JournalingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            JournalingCubit()..fetchJournalEntries(), // Fetch entries on load
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
                    final entries = state.journalEntries;

                    if (entries.isEmpty) {
                      return Center(child: Text('No journal entries yet.'));
                    }

                    return ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        final entry = entries[index];
                        return ListTile(
                          leading: Text(entry['mood'],
                              style: TextStyle(fontSize: 24)),
                          title: Text(entry['content']),
                          subtitle: Text(entry['timestamp']),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('Welcome to Journaling!'));
                  }
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _showAddJournalDialog(context);
                },
                child: Icon(Icons.add),
              ),
            );
          },
        ));
  }

  void _showAddJournalDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    String selectedMood = "😃"; // Default mood

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Journal Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Emoji Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["😃", "😐", "😔"].map((emoji) {
                  return GestureDetector(
                    onTap: () {
                      selectedMood = emoji;
                    },
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: 32),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              // Text Input for Journal
              TextField(
                controller: _controller,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write about your day...",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final content = _controller.text;
                if (content.isNotEmpty) {
                  context
                      .read<JournalingCubit>()
                      .addJournalEntry(selectedMood, content);
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
