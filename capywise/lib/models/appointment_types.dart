import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// EventAppointment represents a regular calendar event
/// Can be assigned any color except red, yellow, and green (which are reserved)
class EventAppointment extends Appointment 
{
  EventAppointment({
    required DateTime startTime,
    required DateTime endTime,
    required String subject,
    Color? color,
    String? notes,
  }) : super(
    startTime: startTime,
    endTime: endTime,
    subject: subject,
    color: color ?? Colors.blue, // Provide a default color if null
    notes: notes,
    isAllDay: false,
  );
}

/// ExamAppointment represents an exam or test with additional information
/// Always displays with a red color for high visibility
class ExamAppointment extends Appointment 
{
  final String location;
  final String examType;
  final String? additionalNotes;

  ExamAppointment({
    required DateTime startTime,
    required DateTime endTime,
    required String subject,
    required this.location,
    required this.examType,
    this.additionalNotes,
    String? notes,
  }) : super(
    startTime: startTime,
    endTime: endTime,
    subject: subject,
    color: Colors.red, // Exams are always red
    notes: notes,
    isAllDay: false,
  );
}

/// Priority levels for reminder appointments
/// Each priority has an associated color
enum ReminderPriority 
{
  low,    // Green
  medium, // Yellow
  high    // Red
}

/// ReminderAppointment represents a task or reminder with priority levels
/// Similar to tasks in Google Calendar
class ReminderAppointment extends Appointment 
{
  final ReminderPriority priority;
  final bool isCompleted;

  ReminderAppointment({
    required DateTime startTime,
    required DateTime endTime,
    required String subject,
    required this.priority,
    this.isCompleted = false,
    String? notes,
  }) : super(
    startTime: startTime,
    endTime: endTime,
    subject: subject,
    color: _getPriorityColor(priority),
    notes: notes,
    isAllDay: false,
  );

  /// Helper method to get appropriate color based on priority
  static Color _getPriorityColor(ReminderPriority priority) 
  {
    switch (priority) 
    {
      case ReminderPriority.low:
        return Colors.green;
      case ReminderPriority.medium:
        return Colors.yellow.shade700;
      case ReminderPriority.high:
        return Colors.red;
    }
  }
}