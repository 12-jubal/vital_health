/// A bottom sheet widget that allows users to add a journal entry with a mood emoji and text content.
///
/// The [AddJournalBottomSheet] widget provides a UI for selecting a mood emoji and entering text content
/// for a journal entry. When the user saves the entry, the [onSave] callback is triggered with the selected
/// mood and content.
///
/// The widget consists of:
/// - A title indicating the purpose of the bottom sheet.
/// - An emoji selector with three mood options: 😃, 😐, and 😔.
/// - A text input field for writing the journal entry.
/// - A save button that triggers the [onSave] callback and closes the bottom sheet.
///
/// The [onSave] callback is required and should handle the logic for saving the journal entry.
///
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
  String selectedMood = "😃"; // Default mood for emoji selector

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
