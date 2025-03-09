import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event Form Test")),
      body: Center(
        child: Text("Press the + button to open the event form"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => EventFormWidget(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EventFormWidget extends StatefulWidget {
  @override
  _EventFormWidgetState createState() => _EventFormWidgetState();
}

class _EventFormWidgetState extends State<EventFormWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedColor = "Yellow"; // Default color

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
    // Handle the save action (print for now)
    print("Event Saved:");
    print("Title: ${titleController.text}");
    print("Place: ${placeController.text}");
    print("Date: ${selectedDate != null ? "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}" : "Not set"}");
    print("Time: ${selectedTime != null ? "${selectedTime!.hour}:${selectedTime!.minute}" : "Not set"}");
    print("Notes: ${notesController.text}");
    print("Color: $selectedColor");

    //Navigator.pop(context); // Close the dialog
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
            // Event Title and Color Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Event Title", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: selectedColor,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedColor = newValue;
                      });
                    }
                  },
                  items: ["Yellow", "Cyan", "Magenta"].map((String color) {
                    return DropdownMenuItem<String>(
                      value: color,
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            margin: EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: _getColorFromString(color),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(color),
                        ],
                      ),
                    );
                  }).toList(),
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
                onPressed: _saveEvent,
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

  // Helper function to get Color from String
  Color _getColorFromString(String color) {
    switch (color) {
      case "Yellow":
        return Colors.yellow;
      case "Cyan":
        return Colors.cyan;
      case "Magenta":
        return Colors.pink; // Magenta isn't a default Flutter color
      default:
        return Colors.grey;
    }
  }
}
