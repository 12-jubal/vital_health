/// A bottom sheet widget that allows users to add a journal entry with a mood and content.
///
/// The [AddJournalBottomSheet] widget provides a UI for selecting a mood (emoji) and
/// writing a journal entry. It includes a title, emoji selector, text input field, and
/// a save button. When the save button is pressed, the selected mood and content are
/// passed to the [onSave] callback function.
///
/// The [onSave] parameter is a required callback function that takes two arguments:
/// - [mood]: A string representing the selected mood (emoji).
/// - [content]: A string representing the journal entry content.
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddJournalBottomSheet extends StatefulWidget {
  final Function(String mood, String content) onSave;

  const AddJournalBottomSheet({super.key, required this.onSave});

  @override
  // ignore: library_private_types_in_public_api
  _AddJournalBottomSheetState createState() => _AddJournalBottomSheetState();
}

class _AddJournalBottomSheetState extends State<AddJournalBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  String selectedMood = "😃"; // Default mood

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            'Add Journal Entry',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          // Emoji Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ["😃", "😐", "😔"].map((emoji) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMood = emoji;
                  });
                },
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: selectedMood == emoji ? Colors.blue : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
          // Text Input
          TextField(
            controller: _controller,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Write about your day...",
            ),
          ),
          SizedBox(height: 16.h),
          // Save Button
          ElevatedButton(
            onPressed: () {
              final content = _controller.text;
              if (content.isNotEmpty) {
                widget.onSave(selectedMood, content);
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
