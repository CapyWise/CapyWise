import 'package:flutter/material.dart';

class EventFormWidget extends StatefulWidget {
  @override
  _EventFormWidgetState createState() => _EventFormWidgetState();
}

class _EventFormWidgetState extends State<EventFormWidget> {
  final TextEditingController placeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Color selectedColor = Colors.pink; // Default color

  final List<Color> colorOptions = [Colors.yellow, Colors.cyan, Colors.pink];

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _saveEvent() {
    print("Event Saved!");
    Navigator.pop(context); // Close dialog after saving
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 440,
        height: 400,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Row: Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context), // Close dialog
                  child: Icon(Icons.close, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 4),

            // Event Title & Color Selector (moved down)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Event Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                _buildColorDropdown(),
              ],
            ),
            SizedBox(height: 16),

            // Place
            _buildButton(Icons.location_on, "Add Place", () {}),

            // Date & Time
            Row(
              children: [
                Expanded(child: _buildButton(Icons.calendar_today, "Add Date", _selectDate)),
                SizedBox(width: 10),
                Expanded(child: _buildButton(Icons.access_time, "Add Time", _selectTime)),
              ],
            ),

            // Notes
            _buildButton(Icons.note, "Add Notes", () {}),

            SizedBox(height: 16),

            // Save Button
            SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: _saveEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Color Dropdown Menu
  Widget _buildColorDropdown() {
    return PopupMenuButton<Color>(
      onSelected: (Color newColor) {
        setState(() {
          selectedColor = newColor;
        });
      },
      itemBuilder: (context) {
        return colorOptions
            //.where((color) => color != selectedColor) // Hide currently selected color
            .map((color) => PopupMenuItem<Color>(
                  value: color,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: color), // Hollow circle
                    ),
                  ),
                ))
            .toList();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.transparent),
                color: selectedColor,
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.arrow_drop_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  // Custom Styled Buttons for Place, Date, Time, Notes
  Widget _buildButton(IconData icon, String text, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          SizedBox(width: 10),
          Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
        ],
      ),
    );
  }
}
