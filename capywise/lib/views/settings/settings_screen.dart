import 'package:flutter/material.dart';
import 'package:capywise/widgets/sidebar_widget.dart';
import 'package:capywise/core/base_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Settings",
      middleContent: const SettingsContentWidget(), // This will be the main settings content
    );
  }
}

class SettingsContentWidget extends StatefulWidget {
  const SettingsContentWidget({super.key});

  @override
  _SettingsContentWidgetState createState() => _SettingsContentWidgetState();
}

class _SettingsContentWidgetState extends State<SettingsContentWidget> {
  bool pushNotifications = false;
  bool emailNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "General",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                    decorationThickness: 2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Appearances",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Profile Picture", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[300],
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
                        _buildSwitch("Push Notifications", pushNotifications, (value) {
                          setState(() {
                            pushNotifications = value;
                          });
                        }),
                        _buildSwitch("Email Notifications", emailNotifications, (value) {
                          setState(() {
                            emailNotifications = value;
                          });
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
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