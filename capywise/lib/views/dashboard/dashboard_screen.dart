import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/base_page.dart';
import '../../core/expandable_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // We'll store each event as a Map with start/end DateTimes, a title, etc.
  final List<Map<String, dynamic>> _events = [
    {
      "title": "TIRADENTES",
      "tag": null,
      "color": const Color(0xFFD9F7BE),
      "start": DateTime(2023, 1, 8, 0, 0), // Jan 8, 12:00 AM
      "end": DateTime(2023, 1, 8, 23, 59),
      "isChecked": true,
    },
    {
      "title": "GREAT ALTERNATIVE",
      "tag": "ASTR132",
      "color": const Color(0xFFFFF4E1),
      "start": DateTime(2023, 1, 10, 15, 0), // Jan 10, 3:00 PM
      "end": DateTime(2023, 1, 10, 18, 0),
      "isChecked": false,
    },
    {
      "title": "SHOOTING STARS",
      "tag": null,
      "color": const Color(0xFFFDD3F8),
      "start": DateTime(2023, 1, 11, 9, 0),
      "end": DateTime(2023, 1, 11, 11, 0),
      "isChecked": false,
    },
    {
      "title": "THE AMAZING HUBBLE",
      "tag": "SPACE",
      "color": const Color(0xFFD6F3FF),
      "start": DateTime(2023, 1, 12, 13, 0),
      "end": DateTime(2023, 1, 12, 14, 0),
      "isChecked": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _sortEvents();
  }

  void _sortEvents() {
    setState(() {
      // Sort by 'start' ascending
      _events.sort((a, b) {
        final dtA = a["start"] as DateTime;
        final dtB = b["start"] as DateTime;
        return dtA.compareTo(dtB);
      });
    });
  }

  // Called when user taps the trash icon
  void _deleteCard(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }

  // Called when user taps the edit icon
  // We let the user change the event's date/time and title
  void _editCard(int index) async {
    final event = _events[index];
    final DateTime oldStart = event["start"];
    final DateTime oldEnd = event["end"];
    final String oldTitle = event["title"];

    // Show a dialog that lets us pick new date/time and title
    final updated = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _EditDialog(
        oldStart: oldStart,
        oldEnd: oldEnd,
        oldTitle: oldTitle,
      ),
    );
    if (updated == null) return;

    // Update the event
    setState(() {
      _events[index]["title"] = updated["title"];
      _events[index]["start"] = updated["start"];
      _events[index]["end"] = updated["end"];
    });
    _sortEvents(); // re-sort after editing
  }

  // Format start/end as "Tue, Jan 10 • 3:00 PM - 6:00 PM"
  String _formatDateTimeRange(DateTime start, DateTime end) {
    final dayFormat = DateFormat('E, MMM d').format(start);
    final startTime = DateFormat('h:mm a').format(start);
    final endTime = DateFormat('h:mm a').format(end);
    return "$dayFormat • $startTime - $endTime";
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Dashboard',

      middleContent: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final e = _events[index];
          final start = e["start"] as DateTime;
          final end = e["end"] as DateTime;
          final dateTimeLabel = _formatDateTimeRange(start, end);

          return ExpandableCard(
            dateTimeLabel: dateTimeLabel,
            title: e["title"],
            tag: e["tag"],
            isChecked: e["isChecked"] ?? false,
            backgroundColor: e["color"],
            onEditPressed: () => _editCard(index),
            onDeletePressed: () => _deleteCard(index),
          );
        },
      ),

      // RIGHT SIDEBAR is optional
      rightSidebar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Center(
          child: Text("Right sidebar content"),
        ),
      ),
      showRightSidebar: true,
    );
  }
}

/// A dialog to edit the event's date/time (start/end) and title.
class _EditDialog extends StatefulWidget {
  final DateTime oldStart;
  final DateTime oldEnd;
  final String oldTitle;

  const _EditDialog({
    Key? key,
    required this.oldStart,
    required this.oldEnd,
    required this.oldTitle,
  }) : super(key: key);

  @override
  State<_EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<_EditDialog> {
  late TextEditingController _titleController;
  late DateTime _localStart;
  late DateTime _localEnd;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.oldTitle);
    _localStart = widget.oldStart;
    _localEnd = widget.oldEnd;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // Pick new date for start, keep the hour/minutes from _localStart
  Future<void> _pickStartDate() async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: _localStart,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (newDate != null) {
      setState(() {
        // Preserve hour/min from old start time
        _localStart = DateTime(
          newDate.year,
          newDate.month,
          newDate.day,
          _localStart.hour,
          _localStart.minute,
        );
      });
    }
  }

  // pick start time (hour/min)
  Future<void> _pickStartTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_localStart),
    );
    if (newTime != null) {
      setState(() {
        _localStart = DateTime(
          _localStart.year,
          _localStart.month,
          _localStart.day,
          newTime.hour,
          newTime.minute,
        );
      });
    }
  }

  // Similarly for end date/time
  Future<void> _pickEndDate() async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: _localEnd,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (newDate != null) {
      setState(() {
        _localEnd = DateTime(
          newDate.year,
          newDate.month,
          newDate.day,
          _localEnd.hour,
          _localEnd.minute,
        );
      });
    }
  }

  Future<void> _pickEndTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_localEnd),
    );
    if (newTime != null) {
      setState(() {
        _localEnd = DateTime(
          _localEnd.year,
          _localEnd.month,
          _localEnd.day,
          newTime.hour,
          newTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yMMMd');
    final timeFormat = DateFormat('h:mm a');

    return AlertDialog(
      title: const Text("Edit Event"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Event Title"),
            ),
            const SizedBox(height: 12),

            // Start date/time
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickStartDate,
                    child: Text(dateFormat.format(_localStart)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickStartTime,
                    child: Text(timeFormat.format(_localStart)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // End date/time
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickEndDate,
                    child: Text(dateFormat.format(_localEnd)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickEndTime,
                    child: Text(timeFormat.format(_localEnd)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Save"),
          onPressed: () {
            final newTitle = _titleController.text.trim();
            // Return updated data to the caller
            Navigator.pop<Map<String, dynamic>>(context, {
              "title": newTitle,
              "start": _localStart,
              "end": _localEnd,
            });
          },
        ),
      ],
    );
  }
}
