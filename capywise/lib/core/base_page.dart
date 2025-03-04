import 'package:flutter/material.dart';
import '../widgets/sidebar_widget.dart';

class BasePage extends StatelessWidget
{
  const BasePage(
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color.fromARGB(
        255,
        250,
        232,
        232,
      ),
      body: Row(
        children:
        [
          const SidebarWidget(),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15
                  ),
                  color: Color(0xFFFCE8E8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Text(
                            "Title",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(
                            height: 5
                          ),
                          DropdownButton<String>(
                            items:
                            [
                              DropdownMenuItem(
                                value: "Option 1",
                                child: Text(
                                  "Option 1"
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Option 2",
                                child: Text(
                                  "Option 2"
                                ),
                              ),
                            ],
                            onChanged: (String? newValue)
                            {
                              // Handle dropdown selection
                            },
                            hint: Text(
                              "Choose something",
                              style: TextStyle(
                                fontFamily: 'Poppins'
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children:
                        [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 43, 10, 48),
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              "Primary Action"
                            ),
                          ),
                          SizedBox(
                            width: 10
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "Default"
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children:
                      [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:
                              [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:
                              [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}