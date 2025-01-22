import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/questions/age/age_page.dart';
import 'package:flutter_application_1/views/questions/traningdays/training_days.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
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
                    "Step 8 of 9",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    "What's your goal?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
            buildFitnessLevelOption('Weight loss'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Gain muscle'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Improve fitness'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
Navigator.push(context, CustomPageRoute(page: const TrainingDays(),transitionType: TransitionType.fade));
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
