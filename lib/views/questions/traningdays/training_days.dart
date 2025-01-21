import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/navigation/navigation_page.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingDays extends StatefulWidget {
  const TrainingDays({super.key});

  @override
  State<TrainingDays> createState() => _TrainingDaysState();
}

class _TrainingDaysState extends State<TrainingDays> {
  List<String> selectedDays = [];

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
                Text(
                  "Step 9 of 9",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "What are the days for training?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
            buildFitnessLevelOption('Sunday'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Monday'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Tuesday'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Wednesday'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Thursday'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Friday'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            buildFitnessLevelOption('Saturday'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .03,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationPage(),));
                        },
                        child: const Text("Finish Steps"))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildFitnessLevelOption(String day) {
    bool isSelected = selectedDays.contains(day);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedDays.remove(day);
          } else {
            selectedDays.add(day);
          }
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
              day,
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
