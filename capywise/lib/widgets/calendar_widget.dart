/*import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Import our appointment types and data source from the separate files
import '../models/calendar_data_source.dart';
import '../models/appointment_types.dart';

class CalendarWidget extends StatefulWidget 
{
  final Function(CalendarTapDetails)? onEventTap;

  const CalendarWidget({super.key, this.onEventTap});

  @override
  CalendarWidgetState createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> 
{
  // Calendar view state management
  CalendarView _calendarView = CalendarView.week; // Default view
  CalendarController _calendarController = CalendarController();
  DateTime _currentDate = DateTime.now();
  DateTime _visibleStartDate = DateTime.now();
  DateTime _visibleEndDate = DateTime.now().add(Duration(days: 30));
  
  // Event data storage
  List<Appointment> _appointments = [];
  
  // Theme colors for different event types
  final Color _primaryPink = Color(0xFFFAEAEC); // Light pink background
  final Color _darkPink = Color(0xFFFF71A4); // Dark pink for UI elements
  final Color _purpleEvent = Color(0xFF9747FF); // Purple for astronomy events
  final Color _greenEvent = Color(0xFF71B760); // Green for shooting stars
  final Color _blueEvent = Color(0xFF4DABF7); // Blue for hubble events

  @override
  void initState() 
  {
    super.initState();
    
    // Initialize the calendar controller with the current view
    _calendarController = CalendarController();
    _calendarController.view = _calendarView;
    
    // Fetch initial event data
    _fetchEventsFromBackend();
  }

  /// Simulates fetching events from a backend API
  /// In a real application, this would make API calls to get event data
  void _fetchEventsFromBackend() 
  {
    final DateTime now = DateTime.now();
    final int currentYear = now.year;
    final int currentMonth = now.month;

    setState(() 
    {
      _appointments = [
        // Regular events (can be any color except red, yellow, green)
        EventAppointment(
          startTime: DateTime(currentYear, currentMonth, 10, 10, 0),
          endTime: DateTime(currentYear, currentMonth, 10, 12, 0),
          subject: 'Team Meeting',
          color: _blueEvent,
          notes: 'Discuss project roadmap',
        ),
        EventAppointment(
          startTime: DateTime(currentYear, currentMonth, 15, 14, 0),
          endTime: DateTime(currentYear, currentMonth, 15, 15, 30),
          subject: 'Client Call',
          color: _purpleEvent,
          notes: 'Review design mockups',
        ),
        EventAppointment(
          startTime: DateTime(currentYear, currentMonth, 18, 9, 0),
          endTime: DateTime(currentYear, currentMonth, 18, 10, 0),
          subject: 'Coffee with Alex',
          color: _darkPink,
        ),
        
        // Exam appointments (always red)
        ExamAppointment(
          startTime: DateTime(currentYear, currentMonth, 12, 9, 0),
          endTime: DateTime(currentYear, currentMonth, 12, 11, 30),
          subject: 'Math Final Exam',
          location: 'Room 302, Science Building',
          examType: 'Written + Multiple Choice',
          additionalNotes: 'Bring calculator and ruler',
        ),
        ExamAppointment(
          startTime: DateTime(currentYear, currentMonth, 20, 14, 0),
          endTime: DateTime(currentYear, currentMonth, 20, 16, 0),
          subject: 'Flutter Development Test',
          location: 'Computer Lab, Tech Building',
          examType: 'Practical Coding',
          additionalNotes: 'Open book',
        ),
        
        // Reminder appointments (green, yellow, red based on priority)
        ReminderAppointment(
          startTime: DateTime(currentYear, currentMonth, 11, 0, 0),
          endTime: DateTime(currentYear, currentMonth, 11, 23, 59),
          subject: 'Submit Project Proposal',
          priority: ReminderPriority.high,
          notes: 'Email to professor by midnight',
        ),
        ReminderAppointment(
          startTime: DateTime(currentYear, currentMonth, 14, 0, 0),
          endTime: DateTime(currentYear, currentMonth, 14, 23, 59),
          subject: 'Buy groceries',
          priority: ReminderPriority.medium,
        ),
        ReminderAppointment(
          startTime: DateTime(currentYear, currentMonth, 16, 0, 0),
          endTime: DateTime(currentYear, currentMonth, 16, 23, 59),
          subject: 'Backup project files',
          priority: ReminderPriority.low,
        ),
        
        // Events for next month
        EventAppointment(
          startTime: DateTime(currentYear, currentMonth + 1, 5, 11, 0),
          endTime: DateTime(currentYear, currentMonth + 1, 5, 12, 30),
          subject: 'Dentist Appointment',
          color: _blueEvent,
        ),
      ];
    });
  }

  /// Navigate to previous month/week using the calendar controller
  void _previousView() 
  {
    if (_calendarView == CalendarView.month) 
    {
      // For month view, move to previous month
      _calendarController.backward!();
    } 
    else 
    {
      // For week view, move to previous week
      _calendarController.backward!();
    }
  }
  
  /// Navigate to next month/week using the calendar controller
  void _nextView() 
  {
    if (_calendarView == CalendarView.month) 
    {
      // For month view, move to next month
      _calendarController.forward!();
    } 
    else 
    {
      // For week view, move to next week
      _calendarController.forward!();
    }
  }

  /// Handle calendar view changes and update the visible date range
  void _onViewChanged(ViewChangedDetails details) 
  {
    // Use addPostFrameCallback to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) 
    {
      if (mounted) 
      {
        setState(() 
        {
          // Update visible date range for possible UI indicators
          _visibleStartDate = details.visibleDates.first;
          _visibleEndDate = details.visibleDates.last;
          
          // Update current date to the middle of visible dates range
          int middleIndex = details.visibleDates.length ~/ 2;
          _currentDate = details.visibleDates[middleIndex];
        });
      }
    });
  }

  /// Toggle between month and week views
  void _toggleCalendarView(int index) 
  {
    setState(() 
    {
      // Set the view based on the index (0 = month, 1 = week)
      _calendarView = index == 0 ? CalendarView.month : CalendarView.week;
      
      // Update the controller to match the new view
      _calendarController.view = _calendarView;
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    // Wrap with Material widget to solve "No Material widget found" error
    return Material(
      color: _primaryPink, // Light pink background from Figma
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main calendar content with rounded corners
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Calendar controls: view toggle, navigation and action buttons
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Month/Week toggle buttons - now with border
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildToggleButton('Month', _calendarView == CalendarView.month, 0),
                              _buildToggleButton('Week', _calendarView == CalendarView.week, 1),
                            ],
                          ),
                        ),
                        
                        // Spacer to push navigation buttons to right
                        Spacer(),
                        
                        // Navigation and action buttons
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: _previousView,
                          color: Colors.grey.shade700,
                          iconSize: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: _nextView,
                          color: Colors.grey.shade700,
                          iconSize: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {},
                          color: Colors.grey.shade700,
                          iconSize: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () {},
                          color: Colors.grey.shade700,
                          iconSize: 20,
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.add, size: 18),
                            onPressed: _addEvent,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Syncfusion Calendar Widget
                  Expanded(
                    child: SfCalendar(
                      controller: _calendarController,
                      view: _calendarView,
                      initialDisplayDate: _currentDate,
                      initialSelectedDate: _currentDate,
                      dataSource: _getCalendarDataSource(),
                      todayHighlightColor: Colors.blue,
                      cellBorderColor: Colors.grey.shade200,
                      backgroundColor: Colors.white,
                      viewHeaderStyle: ViewHeaderStyle(
                        dayTextStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        dateTextStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      headerHeight: 0, // Hide default header
                      showNavigationArrow: false,
                      appointmentBuilder: _appointmentBuilder,
                      monthCellBuilder: _monthCellBuilder,
                      onTap: widget.onEventTap,
                      onViewChanged: _onViewChanged,
                      
                      // Week view specific settings
                      timeSlotViewSettings: TimeSlotViewSettings(
                        timeFormat: 'h a', // Format hours as "1 AM", "2 PM", etc.
                        timeInterval: Duration(hours: 1),
                        timeTextStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        startHour: 0, // Start at midnight
                        endHour: 24, // End at midnight
                        timeIntervalHeight: 50, // Height of each hour slot
                        dayFormat: 'EEE', // Format for day like "Mon", "Tue"
                        dateFormat: 'd', // Format for date like "9", "10"
                        nonWorkingDays: const <int>[], // Show all days including weekends
                      ),
                      
                      // Month view specific settings
                      monthViewSettings: MonthViewSettings(
                        showAgenda: false,
                        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                        appointmentDisplayCount: 2, // Show more events per cell
                        navigationDirection: MonthNavigationDirection.vertical,
                        dayFormat: 'EEE',
                        monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                          todayTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          todayBackgroundColor: Colors.blue,
                          leadingDatesBackgroundColor: Colors.grey.shade50,
                          trailingDatesBackgroundColor: Colors.grey.shade50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Custom month cell builder to match the design requirements
  /// Creates styled date cells for the month view
  Widget _monthCellBuilder(BuildContext context, MonthCellDetails details) 
  {
    // Identify weekend days for styling
    final bool isWeekend = details.date.weekday == DateTime.saturday || 
                          details.date.weekday == DateTime.sunday;
    
    // Identify today's date for special styling
    final bool isToday = DateTime.now().year == details.date.year &&
                         DateTime.now().month == details.date.month &&
                         DateTime.now().day == details.date.day;
                         
    return Container(
      decoration: BoxDecoration(
        color: isWeekend ? Colors.grey.shade50 : Colors.white,
        border: Border.all(
          color: Colors.grey.shade200,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Date indicator at top right with special styling for today
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(4),
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: isToday
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    )
                  : null,
              child: Text(
                details.date.day.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  color: isToday ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Custom toggle button for Month/Week views
  /// Creates a styled button with different appearance based on selection state
  Widget _buildToggleButton(String text, bool isSelected, int index) 
  {
    return GestureDetector(
      onTap: () => _toggleCalendarView(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          // Add subtle inner border to selected toggle for better visibility
          border: isSelected ? Border.all(
            color: Colors.grey.shade200,
            width: 1.0,
          ) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  /// Custom appointment builder that styles events differently based on their type
  /// Handles EventAppointment, ExamAppointment, and ReminderAppointment types
  Widget _appointmentBuilder(BuildContext context, CalendarAppointmentDetails details) 
  {
    final Appointment appointment = details.appointments.first;
    
    // Helper function to format time range in a readable format
    String _formatTimeRange(DateTime start, DateTime end) 
    {
      // Format time as 10:00 AM - 12:00 PM
      String startFormat = '${start.hour > 12 ? start.hour - 12 : start.hour == 0 ? 12 : start.hour}:${start.minute.toString().padLeft(2, '0')} ${start.hour >= 12 ? 'PM' : 'AM'}';
      String endFormat = '${end.hour > 12 ? end.hour - 12 : end.hour == 0 ? 12 : end.hour}:${end.minute.toString().padLeft(2, '0')} ${end.hour >= 12 ? 'PM' : 'AM'}';
      return '$startFormat - $endFormat';
    }
    
    // WEEK VIEW APPOINTMENTS
    if (_calendarView == CalendarView.week) 
    {
      // Exam appointment card for week view
      if (appointment is ExamAppointment) 
      {
        return Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.15),
            border: Border.all(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exam title with exam icon
              Row(
                children: [
                  Icon(Icons.school, size: 12, color: Colors.red),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'EXAM: ${appointment.subject}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              // Time information
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  _formatTimeRange(appointment.startTime, appointment.endTime),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Location
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 10, color: Colors.red),
                    SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        appointment.location,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // Exam type
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  'Type: ${appointment.examType}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }
      // Reminder appointment card for week view
      else if (appointment is ReminderAppointment) 
      {
        // Get appropriate icon for the reminder based on priority
        IconData reminderIcon;
        switch (appointment.priority) 
        {
          case ReminderPriority.high:
            reminderIcon = Icons.priority_high;
            break;
          case ReminderPriority.medium:
            reminderIcon = Icons.radio_button_checked;
            break;
          case ReminderPriority.low:
            reminderIcon = Icons.radio_button_unchecked;
            break;
        }
        
        return Container(
          decoration: BoxDecoration(
            color: appointment.color.withOpacity(0.15),
            border: Border.all(color: appointment.color, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.all(1),
          child: Row(
            children: [
              // Priority icon
              Icon(reminderIcon, size: 14, color: appointment.color),
              SizedBox(width: 4),
              // Task info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Checkbox for completion status
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            border: Border.all(color: appointment.color),
                            color: appointment.isCompleted ? appointment.color : Colors.transparent,
                          ),
                          child: appointment.isCompleted 
                            ? Icon(Icons.check, size: 8, color: Colors.white) 
                            : null,
                        ),
                        SizedBox(width: 4),
                        // Task name
                        Expanded(
                          child: Text(
                            appointment.subject,
                            style: TextStyle(
                              color: appointment.color,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              decoration: appointment.isCompleted 
                                ? TextDecoration.lineThrough 
                                : TextDecoration.none,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // Notes (if available)
                    if (appointment.notes != null && appointment.notes!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 2, left: 16),
                        child: Text(
                          appointment.notes!,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
      // Regular event appointment card for week view
      else 
      {
        return Container(
          decoration: BoxDecoration(
            color: appointment.color.withOpacity(0.15),
            border: Border.all(color: appointment.color, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event title
              Text(
                appointment.subject,
                style: TextStyle(
                  color: appointment.color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Time information
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  _formatTimeRange(appointment.startTime, appointment.endTime),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Additional notes if available
              if (appointment.notes != null)
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    appointment.notes!,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        );
      }
    } 
    // MONTH VIEW APPOINTMENTS
    else 
    {
      // Base container style for month view
      return LayoutBuilder(
        builder: (context, constraints) 
        {
          Widget contentWidget;
          
          // Exam appointment in month view
          if (appointment is ExamAppointment) 
          {
            contentWidget = Row(
              children: [
                Icon(Icons.school, size: 10, color: Colors.white),
                SizedBox(width: 2),
                Expanded(
                  child: Text(
                    'EXAM: ${appointment.subject}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
            
            // Special styling for Exam in month view
            return Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              margin: EdgeInsets.only(bottom: 1, top: 1),
              width: double.infinity,
              child: contentWidget,
            );
          }
          // Reminder appointment in month view
          else if (appointment is ReminderAppointment) 
          {
            // Get appropriate icon for the reminder based on priority
            IconData reminderIcon;
            switch (appointment.priority) 
            {
              case ReminderPriority.high:
                reminderIcon = Icons.priority_high;
                break;
              case ReminderPriority.medium:
                reminderIcon = Icons.radio_button_checked;
                break;
              case ReminderPriority.low:
                reminderIcon = Icons.radio_button_unchecked;
                break;
            }
            
            contentWidget = Row(
              children: [
                Icon(reminderIcon, size: 10, color: appointment.color),
                SizedBox(width: 2),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    border: Border.all(color: appointment.color),
                    color: appointment.isCompleted ? appointment.color : Colors.transparent,
                  ),
                  child: appointment.isCompleted 
                    ? Icon(Icons.check, size: 6, color: Colors.white) 
                    : null,
                ),
                SizedBox(width: 2),
                Expanded(
                  child: Text(
                    appointment.subject,
                    style: TextStyle(
                      color: appointment.color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      decoration: appointment.isCompleted 
                        ? TextDecoration.lineThrough 
                        : TextDecoration.none,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          }
          // Regular event appointment in month view
          else 
          {
            contentWidget = Text(
              appointment.subject,
              style: TextStyle(
                color: appointment.color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          }
          
          // Default container for appointments in month view (except Exams which have special styling)
          if (!(appointment is ExamAppointment)) 
          {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: appointment.color, width: 3),
                ),
                color: appointment.color.withOpacity(0.1),
              ),
              padding: EdgeInsets.only(left: 4, top: 2, bottom: 2),
              margin: EdgeInsets.only(bottom: 1, top: 1),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Content widget (different based on appointment type)
                  contentWidget,
                  // Time information - only for regular events, not for reminders
                  if (!(appointment is ReminderAppointment)) 
                    Text(
                      _formatTimeRange(appointment.startTime, appointment.endTime),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            );
          }
          
          // Return the already created exam-specific container
          return Container(); // This line never executes because exams return early above
          */

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget 
{
  final Function(CalendarTapDetails)? onEventTap;

  const CalendarWidget({super.key, this.onEventTap});

  @override
  CalendarWidgetState createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> 
{
  // Calendar view state management
  CalendarView _calendarView = CalendarView.week; // Default view
  CalendarController _calendarController = CalendarController();
  DateTime _currentDate = DateTime.now();
  DateTime _visibleStartDate = DateTime.now();
  DateTime _visibleEndDate = DateTime.now().add(Duration(days: 30));
  
  // Event data storage
  List<Appointment> _appointments = [];
  
  // Theme colors for different event types
  final Color _primaryPink = Color(0xFFFAEAEC); // Light pink background
  final Color _darkPink = Color(0xFFFF71A4); // Dark pink for UI elements
  final Color _purpleEvent = Color(0xFF9747FF); // Purple for astronomy events
  final Color _greenEvent = Color(0xFF71B760); // Green for shooting stars
  final Color _blueEvent = Color(0xFF4DABF7); // Blue for hubble events

  @override
  void initState() 
  {
    super.initState();
    
    // Initialize the calendar controller with the current view
    _calendarController = CalendarController();
    _calendarController.view = _calendarView;
    
    // Fetch initial event data
    _fetchEventsFromBackend();
  }

  /// Simulates fetching events from a backend API
  /// In a real application, this would make API calls to get event data
  void _fetchEventsFromBackend() 
  {
    final DateTime now = DateTime.now();
    final int currentYear = now.year;
    final int currentMonth = now.month;

    setState(() 
    {
      _appointments = [
        // Example event: Shooting Stars (green)
        Appointment(
          startTime: DateTime(currentYear, currentMonth, 10, 10, 0),
          endTime: DateTime(currentYear, currentMonth, 10, 12, 0),
          subject: 'Shooting Stars',
          color: _greenEvent,
        ),
        // Example event: The Amazing Hubble (blue)
        Appointment(
          startTime: DateTime(currentYear, currentMonth, 11, 13, 0),
          endTime: DateTime(currentYear, currentMonth, 11, 14, 30),
          subject: 'The Amazing Hubble',
          color: _blueEvent,
        ),
        // Example event: Astronomy Binoculars A (purple)
        Appointment(
          startTime: DateTime(currentYear, currentMonth, 9, 20, 0),
          endTime: DateTime(currentYear, currentMonth, 9, 22, 0),
          subject: 'Astronomy Binoculars A',
          color: _purpleEvent,
        ),
        // Example event: Astronomy (pink)
        Appointment(
          startTime: DateTime(currentYear, currentMonth, 12, 14, 0),
          endTime: DateTime(currentYear, currentMonth, 12, 16, 0),
          subject: 'Astronomy Binoculars A',
          color: _darkPink,
        ),
        // Example event: Astronomy spanning multiple hours (purple)
        Appointment(
          startTime: DateTime(currentYear, currentMonth, 8, 20, 0),
          endTime: DateTime(currentYear, currentMonth, 8, 23, 30),
          subject: 'Astronomy Binoculars A',
          color: _purpleEvent,
        ),
        // Example event for next month: Future Telescope Review (blue)
        Appointment(
          startTime: DateTime(currentYear, currentMonth + 1, 2, 10, 0),
          endTime: DateTime(currentYear, currentMonth + 1, 2, 12, 0),
          subject: 'Future Telescope Review',
          color: _blueEvent,
        ),
      ];
    });
  }

  /// Navigate to previous month/week using the calendar controller
  void _previousView() 
  {
    if (_calendarView == CalendarView.month) 
    {
      // For month view, move to previous month
      _calendarController.backward!();
    } 
    else 
    {
      // For week view, move to previous week
      _calendarController.backward!();
    }
  }
  
  /// Navigate to next month/week using the calendar controller
  void _nextView() 
  {
    if (_calendarView == CalendarView.month) 
    {
      // For month view, move to next month
      _calendarController.forward!();
    } 
    else 
    {
      // For week view, move to next week
      _calendarController.forward!();
    }
  }

  /// Handle calendar view changes and update the visible date range
  void _onViewChanged(ViewChangedDetails details) 
  {
    // Use addPostFrameCallback to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) 
    {
      if (mounted) 
      {
        setState(() 
        {
          // Update visible date range for possible UI indicators
          _visibleStartDate = details.visibleDates.first;
          _visibleEndDate = details.visibleDates.last;
          
          // Update current date to the middle of visible dates range
          int middleIndex = details.visibleDates.length ~/ 2;
          _currentDate = details.visibleDates[middleIndex];
        });
      }
    });
  }

  /// Toggle between month and week views
  void _toggleCalendarView(int index) 
  {
    setState(() 
    {
      // Set the view based on the index (0 = month, 1 = week)
      _calendarView = index == 0 ? CalendarView.month : CalendarView.week;
      
      // Update the controller to match the new view
      _calendarController.view = _calendarView;
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    // Wrap with Material widget to solve "No Material widget found" error
    return Material(
      color: _primaryPink, // Light pink background from Figma
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main calendar content with rounded corners
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Calendar controls: view toggle, navigation and action buttons
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Month/Week toggle buttons - now with border
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildToggleButton('Month', _calendarView == CalendarView.month, 0),
                              _buildToggleButton('Week', _calendarView == CalendarView.week, 1),
                            ],
                          ),
                        ),
                        
                        // Spacer to push navigation buttons to right
                        Spacer(),
                        
                        // Navigation and action buttons
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: _previousView,
                          color: Colors.grey.shade700,
                          iconSize: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: _nextView,
                          color: Colors.grey.shade700,
                          iconSize: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {},
                          color: Colors.grey.shade700,
                          iconSize: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () {},
                          color: Colors.grey.shade700,
                          iconSize: 20,
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.add, size: 18),
                            onPressed: _addEvent,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Syncfusion Calendar Widget
                  Expanded(
                    child: SfCalendar(
                      controller: _calendarController,
                      view: _calendarView,
                      initialDisplayDate: _currentDate,
                      initialSelectedDate: _currentDate,
                      dataSource: _getCalendarDataSource(),
                      todayHighlightColor: Colors.blue,
                      cellBorderColor: Colors.grey.shade200,
                      backgroundColor: Colors.white,
                      viewHeaderStyle: ViewHeaderStyle(
                        dayTextStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        dateTextStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      headerHeight: 0, // Hide default header
                      showNavigationArrow: false,
                      appointmentBuilder: _appointmentBuilder,
                      monthCellBuilder: _monthCellBuilder,
                      onTap: widget.onEventTap,
                      onViewChanged: _onViewChanged,
                      
                      // Week view specific settings
                      timeSlotViewSettings: TimeSlotViewSettings(
                        timeFormat: 'h a', // Format hours as "1 AM", "2 PM", etc.
                        timeInterval: Duration(hours: 1),
                        timeTextStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        startHour: 0, // Start at midnight
                        endHour: 24, // End at midnight
                        timeIntervalHeight: 50, // Height of each hour slot
                        dayFormat: 'EEE', // Format for day like "Mon", "Tue"
                        dateFormat: 'd', // Format for date like "9", "10"
                        nonWorkingDays: const <int>[], // Show all days including weekends
                      ),
                      
                      // Month view specific settings
                      monthViewSettings: MonthViewSettings(
                        showAgenda: false,
                        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                        appointmentDisplayCount: 2, // Show more events per cell
                        navigationDirection: MonthNavigationDirection.vertical,
                        dayFormat: 'EEE',
                        monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                          todayTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          todayBackgroundColor: Colors.blue,
                          leadingDatesBackgroundColor: Colors.grey.shade50,
                          trailingDatesBackgroundColor: Colors.grey.shade50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Custom month cell builder to match the design requirements
  /// Creates styled date cells for the month view
  Widget _monthCellBuilder(BuildContext context, MonthCellDetails details) 
  {
    // Identify weekend days for styling
    final bool isWeekend = details.date.weekday == DateTime.saturday || 
                          details.date.weekday == DateTime.sunday;
    
    // Identify today's date for special styling
    final bool isToday = DateTime.now().year == details.date.year &&
                         DateTime.now().month == details.date.month &&
                         DateTime.now().day == details.date.day;
                         
    return Container(
      decoration: BoxDecoration(
        color: isWeekend ? Colors.grey.shade50 : Colors.white,
        border: Border.all(
          color: Colors.grey.shade200,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Date indicator at top right with special styling for today
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(4),
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: isToday
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    )
                  : null,
              child: Text(
                details.date.day.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  color: isToday ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Custom toggle button for Month/Week views
  /// Creates a styled button with different appearance based on selection state
  Widget _buildToggleButton(String text, bool isSelected, int index) 
  {
    return GestureDetector(
      onTap: () => _toggleCalendarView(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          // Add subtle inner border to selected toggle for better visibility
          border: isSelected ? Border.all(
            color: Colors.grey.shade200,
            width: 1.0,
          ) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  /// Custom appointment builder that styles events differently for month and week views
  /// Includes time information for both views
  Widget _appointmentBuilder(BuildContext context, CalendarAppointmentDetails details) 
  {
    final Appointment appointment = details.appointments.first;
    
    // Helper function to format time range in a readable format
    String _formatTimeRange(DateTime start, DateTime end) 
    {
      // Format time as 10:00 AM - 12:00 PM
      String startFormat = '${start.hour > 12 ? start.hour - 12 : start.hour == 0 ? 12 : start.hour}:${start.minute.toString().padLeft(2, '0')} ${start.hour >= 12 ? 'PM' : 'AM'}';
      String endFormat = '${end.hour > 12 ? end.hour - 12 : end.hour == 0 ? 12 : end.hour}:${end.minute.toString().padLeft(2, '0')} ${end.hour >= 12 ? 'PM' : 'AM'}';
      return '$startFormat - $endFormat';
    }
    
    // Style for week view cards with time information
    if (_calendarView == CalendarView.week) 
    {
      return Container(
        decoration: BoxDecoration(
          color: appointment.color.withOpacity(0.15),
          border: Border.all(color: appointment.color, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event title
            Text(
              appointment.subject,
              style: TextStyle(
                color: appointment.color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Time information
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                _formatTimeRange(appointment.startTime, appointment.endTime),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Additional notes if available
            if (appointment.notes != null)
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  appointment.notes!,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      );
    } 
    // Style for month view cards with time information
    else 
    {
      return LayoutBuilder(
        builder: (context, constraints) 
        {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: appointment.color, width: 3), // Thicker left border
              ),
              color: appointment.color.withOpacity(0.1), // Light background
            ),
            padding: EdgeInsets.only(left: 4, top: 2, bottom: 2),
            margin: EdgeInsets.only(bottom: 1, top: 1),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Event title
                Text(
                  appointment.subject,
                  style: TextStyle(
                    color: appointment.color, // Match text color to event color
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Time information
                Text(
                  _formatTimeRange(appointment.startTime, appointment.endTime),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Additional notes if available
                if (appointment.notes != null)
                  Text(
                    appointment.notes!,
                    style: TextStyle(
                      color: Colors.grey.shade600, // Lighter gray for notes
                      fontSize: 8,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          );
        }
      );
    }
  }

  /// Export calendar events to external format
  void _exportEvents() 
  {
    print("Exporting Events...");
    // Would implement actual export functionality here
  }

  /// Import events from external source
  void _importEvents() 
  {
    print("Importing Events...");
    // Would implement actual import functionality here
  }

  /// Add a new event to the calendar
  void _addEvent() 
  {
    print("Add Event Clicked");
    // Would show an event creation dialog or navigate to an event creation page
  }

  /// Get the calendar data source from appointments list
  _CalendarDataSource _getCalendarDataSource() 
  {
    return _CalendarDataSource(_appointments);
  }
}

/// Custom data source class for the SfCalendar
/// Converts appointments list to a format the calendar can use
class _CalendarDataSource extends CalendarDataSource 
{
  _CalendarDataSource(List<Appointment> source) 
  {
    appointments = source;
  }
}
