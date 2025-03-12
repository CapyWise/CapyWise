import 'package:flutter/material.dart';
import 'package:capywise/widgets/sidebar_widget.dart';
import 'package:capywise/core/base_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return BasePage(
      title: "Settings",
      middleContent: const SettingsContentWidget(), // This will be the main settings content
      showRightSidebar: false,
    );
  }
}

class SettingsContentWidget extends StatefulWidget 
{
  const SettingsContentWidget({super.key});

  @override
  _SettingsContentWidgetState createState() => _SettingsContentWidgetState();
}

class _SettingsContentWidgetState extends State<SettingsContentWidget> 
{
  bool pushNotifications = false;
  bool emailNotifications = false;
  String selectedSection = "General";

  @override
  Widget build(BuildContext context) 
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () 
                  {
                    setState(() 
                    {
                      selectedSection = "General";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: _buildSectionText("General"),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSection = "Appearances";
                    });
                  },
                  child: _buildSectionText("Appearances"),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: _buildSettingsContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Builds the section text with the proper styling.
  Widget _buildSectionText(String section) {
    bool isSelected = selectedSection == section;
    TextStyle sectionTextStyle = _buildSectionTextStyle(isSelected);
    
    return Text(
      section,
      style: sectionTextStyle,
    );
  }

  // Helper method to define text style based on whether the section is selected or not.
  TextStyle _buildSectionTextStyle(bool isSelected) {
    FontWeight fontWeight;
    Color color;
    double decorationThickness;
    Color decorationColor;
    TextDecoration decoration;

    if (isSelected) {
      fontWeight = FontWeight.bold;
      color = Colors.red;
      decorationColor = Colors.red;
      decorationThickness = 2.0;
      decoration = TextDecoration.underline;
    } else {
      fontWeight = FontWeight.normal;
      color = Colors.black;
      decorationColor = Colors.black;
      decorationThickness = 0.0;
      decoration = TextDecoration.none;
    }

    return TextStyle(
      fontSize: 20,
      fontWeight: fontWeight,
      fontFamily: 'Poppins',
      color: color,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      decoration: decoration,
      
    );
  }

  //Displays content based off of tab selection, default is 'General'
  Widget _buildSettingsContent() {
    if (selectedSection == "General") 
    {
      return _buildGeneralSettings();
    } 
    else if (selectedSection == "Appearances") 
    {
      return _buildAppearanceSettings();
    } 
    else 
    {
      return const SizedBox(); // Default case, in case of an unknown section
    }
  }

  //General Tab info
  Widget _buildGeneralSettings() 
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Profile Picture", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, color: Colors.red),
            ),
            const SizedBox(width: 10),
            const Text("Upload Image", style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 20),
        _buildTextField("Name", "Account Name Info"),
        _buildTextField("Email Address", "accountemail@email.com"),
        _buildTextField("Phone Number", "1234567890"),
        _buildSwitch("Push Notifications", pushNotifications, (value) 
        {
          setState(() 
          {
            pushNotifications = value;
          });
        }),
        _buildSwitch("Email Notifications", emailNotifications, (value) 
        {
          setState(() 
          {
            emailNotifications = value;
          });
        }),
      ],
    );
  }

//Informaion on Appearance tab
  Widget _buildAppearanceSettings() 
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Theme Settings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
      ],
    );
  }

  //Switch widget
  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) 
  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  // TextBox widget
  Widget _buildTextField(String label, String placeholder) 
  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }
}
