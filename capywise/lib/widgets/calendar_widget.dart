import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  final Function(CalendarTapDetails)? onEventTap;

  const CalendarWidget({super.key, this.onEventTap});

  @override
  CalendarWidgetState createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  CalendarView _calendarView = CalendarView.week; // Default view
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchEventsFromBackend(); // Load events from backend
  }

  // Simulate fetching events from a backend
  void _fetchEventsFromBackend() {
    setState(() {
      _appointments = [
        Appointment(
          startTime: DateTime(2025, 1, 8, 10, 0),
          endTime: DateTime(2025, 1, 8, 12, 0),
          subject: 'Shooting Stars',
          color: Colors.green,
        ),
        Appointment(
          startTime: DateTime(2025, 1, 9, 14, 0),
          endTime: DateTime(2025, 1, 9, 15, 30),
          subject: 'The Amazing Hubble',
          color: Colors.blue,
        ),
        Appointment(
          startTime: DateTime(2025, 1, 8, 15, 0),
          endTime: DateTime(2025, 1, 8, 16, 30),
          subject: 'Astronomy Binoculars',
          color: Colors.red,
        ),
      ];
    });
  }

  // Add a new event
  void _addEvent() {
    // Show a form for adding an event (implement this in your app)
    print("Add Event Clicked");
  }

  // Export calendar data
  void _exportEvents() {
    print("Exporting Events...");
  }

  // Import events from file/backend
  void _importEvents() {
    print("Importing Events...");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.month;
                    });
                  },
                  child: Text(
                    "Month",
                    style: TextStyle(
                      color: _calendarView == CalendarView.month
                          ? Colors.blue
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.week;
                    });
                  },
                  child: Text(
                    "Week",
                    style: TextStyle(
                      color: _calendarView == CalendarView.week
                          ? Colors.blue
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.import_export),
                  onPressed: _importEvents,
                ),
                IconButton(
                  icon: Icon(Icons.file_upload),
                  onPressed: _exportEvents,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addEvent,
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: SfCalendar(
            view: _calendarView,
            dataSource: _getCalendarDataSource(),
            onTap: widget.onEventTap, // Handle event tap
            todayHighlightColor: Colors.blue,
            selectionDecoration: BoxDecoration(
              color: Colors.blue.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  // Data source for the calendar
  _CalendarDataSource _getCalendarDataSource() {
    return _CalendarDataSource(_appointments);
  }
}

// Custom data source class
class _CalendarDataSource extends CalendarDataSource {
  _CalendarDataSource(List<Appointment> source) {
    appointments = source;
  }
}
