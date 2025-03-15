import 'package:syncfusion_flutter_calendar/calendar.dart';

/// Custom data source class for the SfCalendar
/// Converts appointments list to a format the calendar can use
class _CalendarDataSource extends CalendarDataSource 
{
  _CalendarDataSource(List<Appointment> source) 
  {
    appointments = source;
  }
}