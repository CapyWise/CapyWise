import 'package:flutter/material.dart';

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
  Color selectedColor = Colors.pink; // Default color

  final List<Color> colorOptions = [Colors.yellow, Colors.cyan, Colors.pink];
  
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Error messages
  String? titleError;
  String? dateError;
  
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateError = null; // Clear any date error when date is selected
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Validate all inputs
  bool _validateInputs() {
    bool isValid = true;
    
    // Reset error messages first
    setState(() {
      titleError = null;
      dateError = null;
    });
    
    // Title validation
    if (titleController.text.trim().isEmpty) {
      setState(() {
        titleError = "Event title is required";
      });
      isValid = false;
    } else if (titleController.text.trim().length < 3) {
      setState(() {
        titleError = "Title must be at least 3 characters";
      });
      isValid = false;
    }
    
    // Date validation
    if (selectedDate == null) {
      setState(() {
        dateError = "Please select a date";
      });
      isValid = false;
    } else {
      // Validate that date is not in the past
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final selectedDay = DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day);
      
      if (selectedDay.isBefore(today)) {
        setState(() {
          dateError = "Date cannot be in the past";
        });
        isValid = false;
      }
    }
    
    return isValid;
  }

  void _saveEvent() {
    if (_validateInputs()) {
      print("Event Saved with title: ${titleController.text}");
      print("Place: ${placeController.text}");
      print("Date: $selectedDate");
      print("Time: $selectedTime");
      print("Notes: ${notesController.text}");
      print("Color: $selectedColor");
      Navigator.pop(context); // Close dialog after saving
    } else {
      // Show error toast or snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fix the errors before saving"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 440,
        height: 500, // Increased height to accommodate error messages
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
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

              // Event Title & Color Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            hintText: "Event Title",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            errorText: titleError,
                          ),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          onChanged: (value) {
                            if (titleError != null) {
                              setState(() {
                                titleError = null; // Clear error when user types
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  _buildColorDropdown(),
                ],
              ),
              SizedBox(height: 16),

              // Place
              _buildInputField(
                Icons.location_on, 
                "Add Place", 
                placeController,
                56, // Custom height
              ),

              SizedBox(height: 10),

              // Date & Time
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDateField(
                          Icons.calendar_today, 
                          selectedDate != null 
                            ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}" 
                            : "Add Date",
                        ),
                        if (dateError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 4),
                            child: Text(
                              dateError!,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTimeField(
                      Icons.access_time, 
                      selectedTime != null 
                        ? "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}" 
                        : "Add Time",
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Notes
              _buildInputField(
                Icons.note, 
                "Add Notes", 
                notesController,
                120, // Custom height for notes
              ),

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
            .map((color) => PopupMenuItem<Color>(
                  value: color,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
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

  // Custom Styled Input Field
  Widget _buildInputField(IconData icon, String hint, TextEditingController controller, double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
        style: TextStyle(color: Colors.grey[700], fontSize: 16),
        maxLines: null,
      ),
    );
  }

  // Date Field
  Widget _buildDateField(IconData icon, String text) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: dateError != null 
              ? Border.all(color: Colors.red, width: 1.0)
              : null,
        ),
        child: Row(
          children: [
            SizedBox(width: 12),
            Icon(icon, color: Colors.grey[600], size: 20),
            SizedBox(width: 10),
            Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // Time Field
  Widget _buildTimeField(IconData icon, String text) {
    return GestureDetector(
      onTap: _selectTime,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(width: 12),
            Icon(icon, color: Colors.grey[600], size: 20),
            SizedBox(width: 10),
            Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
          ],
        ),
      ),
    );
  }
}