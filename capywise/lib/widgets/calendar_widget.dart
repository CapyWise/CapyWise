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
  Key _calendarKey = UniqueKey(); // Ensures a full rebuild when switching views

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

  // Handle View Switching
  void _toggleCalendarView(int index) {
    setState(() {
      _calendarView = index == 0 ? CalendarView.month : CalendarView.week;
      _calendarKey = UniqueKey(); // Forces the calendar to fully rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100], // Match Figma background color
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Month/Week Toggle Button aligned to the end
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                color: Colors.black,
                isSelected: [
                  _calendarView == CalendarView.month,
                  _calendarView == CalendarView.week
                ],
                onPressed: _toggleCalendarView,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("Month"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("Week"),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10), // Space between toggle and toolbar

          // Toolbar for action buttons
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.import_export, color: Colors.black54),
                  onPressed: _importEvents,
                ),
                _buildDivider(),
                IconButton(
                  icon: Icon(Icons.file_upload, color: Colors.black54),
                  onPressed: _exportEvents,
                ),
                _buildDivider(),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.blue),
                  onPressed: _addEvent,
                ),
              ],
            ),
          ),

          SizedBox(height: 10), // Space between toolbar and calendar

          // Main Calendar View with Dynamic Header
          Expanded(
            child: SfCalendar(
              key: _calendarKey, // Ensures a full rebuild on toggle
              view: _calendarView,
              dataSource: _getCalendarDataSource(),
              todayHighlightColor: Colors.blue,
              headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.center, // Centers the dynamic month label
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              selectionDecoration: BoxDecoration(
                color: Color.fromARGB(50, 50, 100, 255), 
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              monthViewSettings: MonthViewSettings(
                showAgenda: true, // Ensures events appear in Month View
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create a grey divider
  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 24, // Match icon button height
      color: Colors.grey[400], // Light grey color
      margin: EdgeInsets.symmetric(horizontal: 8), // Space between icons
    );
  }

  // Export calendar data
  void _exportEvents() {
    print("Exporting Events...");
  }

  // Import events from file/backend
  void _importEvents() {
    print("Importing Events...");
  }

  // Add a new event
  void _addEvent() {
    print("Add Event Clicked");
  }

  // Get the calendar data source
  _CalendarDataSource _getCalendarDataSource() {
    return _CalendarDataSource(_appointments);
  }
}

// Custom data source for events
class _CalendarDataSource extends CalendarDataSource {
  _CalendarDataSource(List<Appointment> source) {
    appointments = source;
  }
}
