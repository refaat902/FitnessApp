import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/questions/bodyfat/body_fat_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
   bool isCMSelected = true; // Track if KG is selected
  TextEditingController heightController = TextEditingController();

  @override
  void dispose() {
    heightController.dispose();
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
                    "Step 4 of 9",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "how much do you height?",
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
                        isCMSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCMSelected ? Colors.grey[300] : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8),
                        ),
                      ),
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height*.01, horizontal: MediaQuery.sizeOf(context).width*.02),
                      child: Text(
                        'FEET',
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: isCMSelected ? Colors.black54 : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCMSelected = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCMSelected ? Colors.white : Colors.grey[300],
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8),
                        ),
                      ),
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height*.01, horizontal: MediaQuery.sizeOf(context).width*.02),
                      child: Text(
                        'CM',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: isCMSelected ? Colors.black : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*.02,),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: isCMSelected ? 'Enter weight in CM' : 'Enter weight in FEET',
                  suffixText: isCMSelected ? 'cm' : 'feet',
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
Navigator.push(context, CustomPageRoute(page: const BodyFatPage(),transitionType: TransitionType.fade));
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
