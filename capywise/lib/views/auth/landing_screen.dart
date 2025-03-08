import 'package:flutter/material.dart';

class LandingPageFinal extends StatelessWidget {
  const LandingPageFinal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8D9D6), // Set background color here
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top Padding
            const SizedBox(height: 40),

            // Image
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 524,
                  height: 490,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("../assets/images/backsplash.webp"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                Positioned(
                  top: 0,
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Get Started Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          onPressed: () {
                            print("Get Started button pressed");
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),
                        
                        // Login Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF271908),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          onPressed: () {
                            print("Login button pressed");
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                    ]
                  ),
                ),
                const SizedBox(height: 20),

                Positioned(
                  bottom: 16,
                  child:
                    Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("../assets/images/capybara.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ), 
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'CapyWise',
              style: TextStyle(
                color: Color(0xFF271908),
                fontSize: 64,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 320),
              child: Text(
                'We are CapyWise, a team of passionate students dedicated to simplifying academic scheduling. Our goal is to help students stay organized and stress-free with an all-in-one calendar solution!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  height: 2,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Features Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FeatureCard(
                    title: 'Calendar',
                    description: 'Keep track of your daily schedule, assignments, and events all in one place.',
                    imagePath: "../assets/images/calendar_icon.webp",
                    color: Color(0xFFDDAF82),
                  ),
                  FeatureCard(
                    title: 'Exam Scheduler',
                    description: 'Plan and manage your final exams effortlessly to avoid last-minute stress.',
                    imagePath: "../assets/images/exam_scheduler_icon.png",
                    color: Color(0xFFFDF5D5),
                  ),
                  FeatureCard(
                    title: 'Reminders',
                    description: 'Set notifications for important deadlines, exams, and tasks to stay on top of your academic life.',
                    imagePath: "../assets/images/reminder_icon.png",
                    color: Color(0xFFEA6D61),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color color;

  const FeatureCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$title card tapped');
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF252525),
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF252525),
                fontSize: 16,
                fontFamily: 'Poppins',
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
