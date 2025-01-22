import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/questions/age/age_page.dart';
import 'package:flutter_application_1/views/questions/goal/goal_page.dart';
import 'package:google_fonts/google_fonts.dart';

class FitnessLevelPage extends StatefulWidget {
  const FitnessLevelPage({super.key});

  @override
  State<FitnessLevelPage> createState() => _FitnessLevelPageState();
}

class _FitnessLevelPageState extends State<FitnessLevelPage> {
  String selectedLevel = 'Beginner'; // Track the selected fitness level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height * .03,
          top: MediaQuery.sizeOf(context).height * .03,
          left: MediaQuery.sizeOf(context).width * .03,
          right: MediaQuery.sizeOf(context).width * .03,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    "Step 7 of 9",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    "What's your fitness level?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
            buildFitnessLevelOption('Beginner'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Intermediate'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Advanced'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
Navigator.push(context, CustomPageRoute(page: const GoalPage(),transitionType: TransitionType.fade));
                        },
                        child: const Text("Next Step"))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build each fitness level option
  GestureDetector buildFitnessLevelOption(String level) {
    bool isSelected = selectedLevel == level;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLevel = level; // Update selected level
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * .01,
            horizontal: MediaQuery.sizeOf(context).width * .02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              level,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
