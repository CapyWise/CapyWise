import 'package:flutter/material.dart';

class EventFormWidget extends StatefulWidget {
  @override
  _EventFormWidgetState createState() => _EventFormWidgetState();
}

class _EventFormWidgetState extends State<EventFormWidget> {
  bool isToggled = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
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
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Title and Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Event Title", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Switch(
                  value: isToggled,
                  activeColor: Colors.pink,
                  onChanged: (value) {
                    setState(() {
                      isToggled = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            
            // Place
            TextField(
              controller: placeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on),
                hintText: "Add Place",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),

            // Date and Time Row
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: _selectDate,
                    icon: Icon(Icons.calendar_today),
                    label: Text(selectedDate == null
                        ? "Add Date"
                        : "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}"),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: _selectTime,
                    icon: Icon(Icons.access_time),
                    label: Text(selectedTime == null
                        ? "Add Time"
                        : "${selectedTime!.hour}:${selectedTime!.minute}"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Notes
            TextField(
              controller: notesController,
              maxLines: 2,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note),
                hintText: "Add Notes",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 15),

            // Save Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle save action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
