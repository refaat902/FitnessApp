import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/questions/height/height_page.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalWeightPage extends StatefulWidget {
  const GoalWeightPage({super.key});

  @override
  State<GoalWeightPage> createState() => _GoalWeightPageState();
}

class _GoalWeightPageState extends State<GoalWeightPage> {
   bool isKgSelected = true; // Track if KG is selected
  TextEditingController weightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }
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
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Step 3 of 9",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "what's your goal weight?",
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isKgSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isKgSelected ? Colors.grey[300] : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8),
                        ),
                      ),
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height*.01, horizontal: MediaQuery.sizeOf(context).width*.02),
                      child: Text(
                        'LBS',
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: isKgSelected ? Colors.black54 : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isKgSelected = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isKgSelected ? Colors.white : Colors.grey[300],
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8),
                        ),
                      ),
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height*.01, horizontal: MediaQuery.sizeOf(context).width*.02),
                      child: Text(
                        'KG',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: isKgSelected ? Colors.black : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.02,),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: isKgSelected ? 'Enter weight in KG' : 'Enter weight in LBS',
                  suffixText: isKgSelected ? 'kg' : 'lbs',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.1,),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HeightPage(),
                                ));
                          },
                          child: const Text("Next Step"))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
